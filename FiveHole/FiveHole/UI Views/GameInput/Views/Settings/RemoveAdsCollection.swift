//
//  RemoveAdsCollection.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/23/20.
//  Updated for StoreKit 2 on 12/26/24
//

import SwiftUI
import SpriteKit
import StoreKit

struct RemoveAdsCollection: View {
    
    @ObservedObject var storeManager: StoreManager
    @State private var showingPurchaseSuccess = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if storeManager.isLoading {
                    ProgressView("Loading products...")
                } else if storeManager.products.isEmpty {
                    VStack {
                        Text("No products available")
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task {
                                await storeManager.loadProducts()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    List {
                        ForEach(storeManager.products, id: \.id) { product in
                            ProductRow(
                                product: product,
                                storeManager: storeManager,
                                showingPurchaseSuccess: $showingPurchaseSuccess
                            )
                        }
                    }
                }
            }
            .navigationTitle("Remove Ads?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Restore Purchases") {
                        Task {
                            await storeManager.restorePurchases()
                        }
                    }
                    .disabled(storeManager.isLoading)
                }
            }
            .alert("Purchase Successful!", isPresented: $showingPurchaseSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Thank you for your support! 🎉")
            }
            .alert("Error", isPresented: .constant(storeManager.errorMessage != nil)) {
                Button("OK") {
                    storeManager.errorMessage = nil
                }
            } message: {
                if let error = storeManager.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

struct ProductRow: View {
    let product: Product
    @ObservedObject var storeManager: StoreManager
    @Binding var showingPurchaseSuccess: Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(productColor)
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: productIcon)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.displayName)
                    .font(.headline)
                Text(product.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                if storeManager.isPurchased(product.id) {
                    Text("✓ Purchased")
                        .font(.caption)
                        .foregroundColor(.green)
                        .bold()
                } else {
                    Text(product.displayPrice)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            // Don't allow purchasing if already owned
            guard !storeManager.isPurchased(product.id) else {
                return
            }
            
            Task {
                do {
                    if let _ = try await storeManager.purchase(product) {
                        await MainActor.run {
                            showingPurchaseSuccess = true
                        }
                    }
                } catch {
                    print("Purchase failed: \(error)")
                }
            }
        }
        .opacity(storeManager.isPurchased(product.id) ? 0.6 : 1.0)
    }
    
    private var productColor: Color {
        switch product.id {
        case ProductID.removeAds:
            return .red
        case ProductID.coffee:
            return .brown
        case ProductID.beer:
            return .orange
        case ProductID.burger:
            return .yellow
        case ProductID.premium:
            return .purple
        default:
            return .blue
        }
    }
    
    private var productIcon: String {
        switch product.id {
        case ProductID.removeAds:
            return "xmark.circle.fill"
        case ProductID.coffee:
            return "cup.and.saucer.fill"
        case ProductID.beer:
            return "wineglass.fill"
        case ProductID.burger:
            return "cart.fill"
        case ProductID.premium:
            return "star.fill"
        default:
            return "gift.fill"
        }
    }
}

struct RemoveAdsCollection_Previews: PreviewProvider {
    static var previews: some View {
        RemoveAdsCollection(storeManager: StoreManager())
    }
}
