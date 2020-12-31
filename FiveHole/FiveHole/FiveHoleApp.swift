//
//  FiveHoleApp.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI
import Firebase

@main
struct FiveHoleApp: App {
    
    let persistenceController = PersistenceController.shared
    
    init(){
        //config app -
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            TabContainerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct FiveHoleApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
