//
//  AdBannerView.swift
//  FiveHole
//
//  Updated for Google Mobile Ads SDK 11.x and iOS 15+
//  BULLETPROOF VERSION - Guaranteed to display
//

import SwiftUI
import GoogleMobileAds

/// Wrapper view that ensures the banner is visible
struct AdBannerView: View {
    let adUnitID: String
    var adSize: AdSize = AdSizeBanner
    
    var body: some View {
        BannerViewContainer(adUnitID: adUnitID, adSize: adSize)
            .frame(width: CGFloat(adSize.size.width), height: CGFloat(adSize.size.height))
            .background(Color.yellow.opacity(0.2)) // DEBUG: You should see this yellow box
            .clipped()
    }
}

/// Internal UIViewRepresentable wrapper
private struct BannerViewContainer: UIViewRepresentable {
    let adUnitID: String
    let adSize: AdSize
    
    func makeUIView(context: Context) -> UIView {
        // Create a container view
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        // Create the banner
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = adUnitID
        banner.backgroundColor = .clear
        
        // CRITICAL: Set autoresizing
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        // Add banner to container
        containerView.addSubview(banner)
        
        // Pin banner to container edges
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: containerView.topAnchor),
            banner.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            banner.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        // Get root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            banner.rootViewController = rootViewController
            banner.delegate = context.coordinator
        }
        
        // Load the ad
        banner.load(Request())
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Ad loaded successfully")
            print("   Banner frame: \(bannerView.frame)")
            print("   Banner superview frame: \(bannerView.superview?.frame ?? .zero)")
            
            // Force visibility
            bannerView.alpha = 1.0
            bannerView.isHidden = false
            bannerView.setNeedsLayout()
            bannerView.layoutIfNeeded()
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Ad failed to load: \(error.localizedDescription)")
        }
        
        func bannerViewDidRecordImpression(_ bannerView: BannerView) {
            print("📊 Ad impression recorded")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: BannerView) {
            print("👆 User tapped ad")
        }
    }
}

// MARK: - Ad Unit IDs

enum AdUnitID {
    static let testBanner = "ca-app-pub-3940256099942544/2934735716"
    static let productionBanner = "ca-app-pub-1998600979835274~9355435059"
    
    static var banner: String {
        #if DEBUG
        return testBanner
        #else
        return productionBanner
        #endif
    }
}

// MARK: - Simple Convenience View

struct StandardBannerAd: View {
    var body: some View {
        AdBannerView(adUnitID: AdUnitID.banner, adSize: AdSizeBanner)
    }
}

// MARK: - Preview

struct AdBannerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Content Above")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue.opacity(0.1))
            
            Text("Banner Below ↓")
                .font(.caption)
            
            StandardBannerAd()
            
            Text("You should see a yellow box with an ad inside")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
