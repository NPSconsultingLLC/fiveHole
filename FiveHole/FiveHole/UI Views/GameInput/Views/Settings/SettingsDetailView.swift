//
//  SettingsDetailView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/23/20.
//

import SwiftUI
import StoreKit

struct SettingsDetailView: View {
    @StateObject var storeManager = StoreManager()
    
    let productIDs = [
        "com.strykeout.goalieScout2.RemoveAds",
        "com.strykeout.goalieScout2.Beer",
        "com.strykeout.goalieScout2.Burger",
        "com.stryekout.goalieScout2.Coffee",
        "com.strykeout.goalieScout2.wow",
    ]
    
    var body: some View {
        RemoveAdsCollection(storeManager: storeManager)
            .onAppear(perform: {
                SKPaymentQueue.default().add(storeManager)
                storeManager.getProducts(productIDs: productIDs)
            })
    }
}

struct SettingsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDetailView()
    }
}
