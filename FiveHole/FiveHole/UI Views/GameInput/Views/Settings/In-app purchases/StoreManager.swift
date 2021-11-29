//
//  StoreManager.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/23/20.
//
import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var myProducts = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    var request: SKProductsRequest!
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Did receive response")
        
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                //processing show spinner possibly
                transactionState = .purchasing
            case .purchased:
                //set ads to hide
                transactionState = .purchased
            case .restored:
                //set ads to hide
                transactionState = .restored
            case .failed, .deferred:
                //alert user to falure
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
        
    //URL https://blckbirds.com/post/how-to-use-in-app-purchases-in-swiftui-apps/
}
