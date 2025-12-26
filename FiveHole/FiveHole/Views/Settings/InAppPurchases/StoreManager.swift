//
//  StoreManager.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/23/20.
//  Updated for StoreKit 2 (iOS 15+) on 12/26/24
//

import Foundation
import StoreKit

/// Product identifiers for in-app purchases
enum ProductID {
    static let removeAds = "com.strykeout.goalieScout2.RemoveAds"
    static let coffee = "com.stryekout.goalieScout2.Coffee"
    static let beer = "com.strykeout.goalieScout2.Beer"
    static let burger = "com.strykeout.goalieScout2.Burger"
    static let premium = "com.strykeout.goalieScout2.wow"
    
    static var all: [String] {
        [removeAds, coffee, beer, burger, premium]
    }
}

/// Modern StoreKit 2 implementation
@MainActor
class StoreManager: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Available products from App Store Connect
    @Published private(set) var products: [Product] = []
    
    /// Set of purchased product IDs
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    /// Loading state
    @Published var isLoading = false
    
    /// Error message
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    
    private var updateListenerTask: Task<Void, Error>?
    
    // MARK: - Initialization
    
    init() {
        // Start listening for transaction updates
        updateListenerTask = listenForTransactions()
        
        // Load products and check for purchases
        Task {
            await loadProducts()
            await updatePurchasedProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    // MARK: - Product Loading
    
    /// Load products from App Store Connect
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await Product.products(for: ProductID.all)
            print("✅ Loaded \(products.count) products")
        } catch {
            errorMessage = "Failed to load products: \(error.localizedDescription)"
            print("❌ \(errorMessage ?? "")")
        }
        
        isLoading = false
    }
    
    // MARK: - Purchase
    
    /// Purchase a product
    func purchase(_ product: Product) async throws -> Transaction? {
        isLoading = true
        errorMessage = nil
        
        let result = try await product.purchase()
        isLoading = false
        
        switch result {
        case .success(let verification):
            // Check verification
            let transaction = try checkVerified(verification)
            
            // Update purchased products
            await updatePurchasedProducts()
            
            // Finish the transaction
            await transaction.finish()
            
            print("✅ Purchase successful: \(product.displayName)")
            return transaction
            
        case .userCancelled:
            print("ℹ️ User cancelled purchase")
            return nil
            
        case .pending:
            print("⏳ Purchase pending approval")
            return nil
            
        @unknown default:
            return nil
        }
    }
    
    // MARK: - Restore Purchases
    
    /// Restore previous purchases
    func restorePurchases() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await AppStore.sync()
            await updatePurchasedProducts()
            print("✅ Purchases restored")
        } catch {
            errorMessage = "Failed to restore purchases: \(error.localizedDescription)"
            print("❌ \(errorMessage ?? "")")
        }
        
        isLoading = false
    }
    
    // MARK: - Check Purchases
    
    /// Update the set of purchased product IDs
    func updatePurchasedProducts() async {
        var newPurchasedIDs = Set<String>()
        
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            
            // Only include non-revoked purchases
            if transaction.revocationDate == nil {
                newPurchasedIDs.insert(transaction.productID)
            }
        }
        
        purchasedProductIDs = newPurchasedIDs
        print("📊 Purchased products: \(purchasedProductIDs)")
    }
    
    /// Check if user has purchased a specific product
    func isPurchased(_ productID: String) -> Bool {
        purchasedProductIDs.contains(productID)
    }
    
    /// Check if ads should be removed
    var shouldRemoveAds: Bool {
        // Ads are removed if ANY purchase is made
        !purchasedProductIDs.isEmpty
    }
    
    // MARK: - Transaction Listener
    
    /// Listen for transaction updates
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            // Iterate through any transactions that don't come from a direct call to `purchase()`
            for await result in Transaction.updates {
                guard case .verified(let transaction) = result else {
                    continue
                }
                
                // Update purchased products
                await self.updatePurchasedProducts()
                
                // Finish the transaction
                await transaction.finish()
                
                print("✅ Transaction updated: \(transaction.productID)")
            }
        }
    }
    
    // MARK: - Verification
    
    /// Check and unwrap a verified result
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}

// MARK: - Store Error

enum StoreError: LocalizedError {
    case failedVerification
    
    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return "Transaction verification failed"
        }
    }
}


