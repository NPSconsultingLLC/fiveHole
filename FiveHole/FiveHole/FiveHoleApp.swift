//
//  FiveHoleApp.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

@main
struct FiveHoleApp: App {
    
    let productIDs = [
        "com.strykeout.goalieScout2.RemoveAds",
        "com.strykeout.goalieScout2.Beer",
        "com.strykeout.goalieScout2.Burger",
        "com.stryekout.goalieScout2.Coffee",
        "com.strykeout.goalieScout2.wow",
    ]
    
    @StateObject var storeManager = StoreManager()
    
    let persistenceController = PersistenceController.shared
    
    init(){
        //config app - 
    }

    var body: some Scene {
        WindowGroup {
            TabContainerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                                    storeManager.getProducts(productIDs: productIDs)
                                })
        }
    }
}

struct FiveHoleApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
