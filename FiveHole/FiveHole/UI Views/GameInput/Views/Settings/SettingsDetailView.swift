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
    @State var detailView = DetailViews.removeAds
    
    enum DetailViews {
        case removeAds
        case credits
    }

    let productIDs = [
        "com.strykeout.goalieScout2.RemoveAds",
        "com.strykeout.goalieScout2.Beer",
        "com.strykeout.goalieScout2.Burger",
        "com.stryekout.goalieScout2.Coffee",
        "com.strykeout.goalieScout2.wow",
    ]
    
    var body: some View {
        Group {
            if detailView == .removeAds {
            RemoveAdsCollection(storeManager: storeManager)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIDs)
                })
            } else if detailView == .credits {
                CreditsView()
            }
        }
    }
}

//struct SettingsDetailView_Previews: PreviewProvider {
//    @State var detailViews = .removeAds
//    static var previews: some View {
//        SettingsDetailView(, detailViews: detailViews.removeAds)
//    }
//}
