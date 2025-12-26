//
//  Persistence.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//  Updated for iOS 15+ on 12/26/24
//

@preconcurrency import CoreData
import Combine

@MainActor
class PersistenceController: ObservableObject {
    static let shared = PersistenceController()

    // Preview instance for SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Create sample goalies for previews
        let sampleGoalie1 = Goalies(context: viewContext)
        sampleGoalie1.fName = "John"
        sampleGoalie1.lName = "Doe"
        sampleGoalie1.tName = "Sample Team"
        sampleGoalie1.id = UUID()
        sampleGoalie1.selectedGoalie = true
        
        let sampleGoalie2 = Goalies(context: viewContext)
        sampleGoalie2.fName = "Jane"
        sampleGoalie2.lName = "Smith"
        sampleGoalie2.tName = "Another Team"
        sampleGoalie2.id = UUID()
        sampleGoalie2.selectedGoalie = false
        
        do {
            try viewContext.save()
            print("✅ Preview data created successfully")
        } catch {
            let nsError = error as NSError
            print("❌ Preview data creation failed: \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "FiveHole")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Configure CloudKit options
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to retrieve persistent store description")
        }
        
        // Enable persistent history tracking for CloudKit sync
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Production-ready error handling
                print("❌ Core Data Error: \(error.localizedDescription)")
                print("Error Info: \(error.userInfo)")
                
                // In production, you might want to:
                // 1. Show an alert to the user
                // 2. Try to recover by deleting and recreating the store
                // 3. Log to analytics/crash reporting
                
                #if DEBUG
                fatalError("Unresolved error \(error), \(error.userInfo)")
                #endif
            } else {
                print("✅ Core Data store loaded successfully")
            }
        }
        
        // Configure context for better CloudKit sync
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Optional: Set name for debugging
        container.viewContext.name = "viewContext"
        
        // iOS 15+: Configure automatic save
        container.viewContext.shouldDeleteInaccessibleFaults = true
    }
    
    // MARK: - Save Methods
    
    /// Synchronous save (use for quick saves on main thread)
    func save() {
        let context = container.viewContext
        
        guard context.hasChanges else {
            print("ℹ️ No changes to save")
            return
        }
        
        do {
            try context.save()
            print("✅ Data saved successfully")
        } catch {
            let nsError = error as NSError
            print("❌ Save failed: \(nsError.localizedDescription)")
            print("Error Info: \(nsError.userInfo)")
            
            // Handle specific errors
            if nsError.code == NSManagedObjectValidationError {
                print("❌ Validation error - check your data model constraints")
            }
        }
    }
    
    /// Async save (iOS 15+) - use for background saves
    func saveAsync() async throws {
        let context = container.viewContext
        
        try await context.perform {
            guard context.hasChanges else { return }
            try context.save()
        }
        print("✅ Data saved asynchronously")
    }
    
    // MARK: - Fetch Methods (iOS 15+ async/await)
    
    /// Fetch all goalies asynchronously
    func fetchGoalies() async throws -> [Goalies] {
        let context = container.viewContext
        
        return try await context.perform {
            let request = Goalies.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \Goalies.fName, ascending: true),
                NSSortDescriptor(keyPath: \Goalies.lName, ascending: true)
            ]
            return try context.fetch(request)
        }
    }
    
    /// Fetch selected goalie asynchronously
    func fetchSelectedGoalie() async throws -> Goalies? {
        let context = container.viewContext
        
        return try await context.perform {
            let request = Goalies.fetchRequest()
            request.predicate = NSPredicate(format: "selectedGoalie == YES")
            request.fetchLimit = 1
            return try context.fetch(request).first
        }
    }
    
    /// Fetch games for a specific goalie
    func fetchGames(for goalie: Goalies) async throws -> [Games] {
        let context = container.viewContext
        let goalieID = goalie.objectID
        
        return try await context.perform {
            let goalieInContext = context.object(with: goalieID) as! Goalies
            let request = Games.fetchRequest()
            request.predicate = NSPredicate(format: "toGoalie == %@", goalieInContext)
            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \Games.gameDate, ascending: false)
            ]
            return try context.fetch(request)
        }
    }
    
    // MARK: - Delete Methods
    
    /// Delete object and save
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    
    /// Async delete
    func deleteAsync(_ object: NSManagedObject) async throws {
        let context = container.viewContext
        let objectID = object.objectID
        
        await context.perform {
            let objectToDelete = context.object(with: objectID)
            context.delete(objectToDelete)
        }
        try await saveAsync()
    }
    
    // MARK: - Batch Operations
    
    /// Batch delete all games (useful for testing)
    func deleteAllGames() async throws {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Games.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        let result = try await context.perform {
            try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
        }
        
        // Merge changes into context
        if let objectIDArray = result?.result as? [NSManagedObjectID] {
            let changes = [NSDeletedObjectsKey: objectIDArray]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        }
    }
    
    // MARK: - CloudKit Sync
    
    /// Check if CloudKit is available
    var isCloudKitAvailable: Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }
    
    /// Export CloudKit activity (for debugging)
    func exportCloudKitActivity() {
        let activity = container.persistentStoreCoordinator.persistentStores.first?.metadata
        print("📊 CloudKit Metadata: \(activity ?? [:])")
    }
}

// MARK: - Helper Extensions

extension PersistenceController {
    /// Create a new goalie
    func createGoalie(firstName: String, lastName: String, teamName: String, isSelected: Bool = false) -> Goalies {
        let goalie = Goalies(context: container.viewContext)
        goalie.id = UUID()
        goalie.fName = firstName
        goalie.lName = lastName
        goalie.tName = teamName
        goalie.selectedGoalie = isSelected
        return goalie
    }
    
    /// Create a new game
    func createGame(
        for goalie: Goalies,
        opponent: String,
        saves: Int16,
        goalsAgainst: Int16,
        goalsFor: Int16,
        date: Date = Date(),
        isWin: Bool
    ) -> Games {
        let game = Games(context: container.viewContext)
        game.id = UUID()
        game.toGoalie = goalie
        game.opponent = opponent
        game.saves = saves
        game.totalShots = saves + goalsAgainst
        game.goalsFor = goalsFor
        game.gameDate = date
        game.isWin = isWin
        
        // Calculate season from date (example: year)
        let calendar = Calendar.current
        game.season = Int16(calendar.component(.year, from: date))
        
        return game
    }
}
