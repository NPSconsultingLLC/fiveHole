//
//  AdBannerView.swift
//  FiveHole
//
//  Updated for Google Mobile Ads SDK 11.x and iOS 15+
//

import SwiftUI
import GoogleMobileAds

/// Modern ad banner view compatible with Google Mobile Ads SDK 11.x
struct AdBannerView: UIViewRepresentable {
    /// The ad unit ID to use. Use test ID for development:
    /// Test Banner ID: "ca-app-pub-3940256099942544/2934735716"
    let adUnitID: String
    
    /// Ad size (default is standard banner)
    var adSize: AdSize = AdSizeBanner
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = adUnitID
        
        // iOS 15+ way to get root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            banner.rootViewController = rootViewController
            banner.delegate = context.coordinator
        }
        
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Ad loaded successfully")
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
        
        func bannerViewWillDismissScreen(_ bannerView: BannerView) {
            print("👋 Ad dismissing")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: BannerView) {
            print("✅ Ad dismissed")
        }
    }
}

// MARK: - Production Ad Unit IDs

enum AdUnitID {
    /// Test banner ad ID (use during development)
    static let testBanner = "ca-app-pub-3940256099942544/2934735716"
    
    /// Production banner ad ID (replace with your actual ID)
    static let productionBanner = "ca-app-pub-1998600979835274~9355435059"
    
    /// Get the appropriate ad unit ID based on build configuration
    static var banner: String {
        #if DEBUG
        return testBanner
        #else
        return productionBanner
        #endif
    }
}

// MARK: - Convenience Views

/// Standard banner ad (320x50)
struct StandardBannerAd: View {
    var body: some View {
        AdBannerView(adUnitID: AdUnitID.banner)
            .frame(height: 50)
    }
}

/// Large banner ad (320x100)
struct LargeBannerAd: View {
    var body: some View {
        AdBannerView(adUnitID: AdUnitID.banner, adSize: AdSizeLargeBanner)
            .frame(height: 100)
    }
}

/// Smart banner ad (adapts to screen width)
struct SmartBannerAd: View {
    var body: some View {
        AdBannerView(
            adUnitID: AdUnitID.banner,
            adSize: currentOrientationAnchoredAdaptiveBanner(width: UIScreen.main.bounds.width)
        )
        .frame(maxWidth: .infinity)
        .frame(height: 50) // Approximate height
    }
}

// MARK: - Preview Provider

struct AdBannerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("Standard Banner")
            StandardBannerAd()
            
            Text("Large Banner")
            LargeBannerAd()
            
            Text("Smart Banner")
            SmartBannerAd()
        }
        .padding()
    }
}
