//
//  toDelete_AdView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 1/4/21.
//

import SwiftUI
import GoogleMobileAds

struct toDelete_AdView: View {
    var body: some View {
        adView()
    }
}

struct toDelete_AdView_Previews: PreviewProvider {
    static var previews: some View {
        toDelete_AdView()
    }
}

struct adView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<adView>) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner) 
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        // iOS 15+ way to get root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            banner.rootViewController = rootViewController
        }
        
        banner.load(Request())
        return banner
    }

    func updateUIView(_ uiView: BannerView, context: UIViewRepresentableContext<adView>) {
        // No-op
    }
}
