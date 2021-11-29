//
//  RemoveAdsCollection.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/23/20.
//

import SwiftUI
import SpriteKit

//TODO add Fireworks View when somebody buys something successfully

struct RemoveAdsCollection: View {
    
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        NavigationView{
            List{
                HStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Text("Remove adds for the low low price of $0.99")
                }.padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    storeManager.purchaseProduct(product: storeManager.myProducts[0])
                })
                HStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Text("Buy Nathan a cup of coffee $1.99")
                }.padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    //Remove ads for 1.99
                })
                HStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Text("Buy Nathan a hoppy IPA $5.99")
                }.padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    //Remove ads for 5.99
                })
                HStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Text("Buy Nathan a delicious impossible burger $9.99")
                }.padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    //Remove ads for 9.99
                })
                HStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    Text("Nobody has every given me 99.99 seriously don't do this")
                }.padding()
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    //Remove ads for 5.99
                })
            }
            .navigationTitle("Remove Ads?")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        storeManager.restoreProducts()
                    }) {
                        Text("Restore Purchases")
                    }
                }
            })
        }
    }
}

struct RemoveAdsCollection_Previews: PreviewProvider {
    static var previews: some View {
        RemoveAdsCollection(storeManager: StoreManager())
    }
}
