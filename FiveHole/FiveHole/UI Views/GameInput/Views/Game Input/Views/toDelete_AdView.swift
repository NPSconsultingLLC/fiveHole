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
    func makeUIView(context: UIViewRepresentableContext<adView>) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<adView>) {

    }
}
