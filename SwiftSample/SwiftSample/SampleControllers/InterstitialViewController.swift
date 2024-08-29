//
//  InterstitialViewController.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 11/10/2023.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a simple interstitial.
 
 This interstitial is loaded and displayed in 2 steps. It automatically covers the whole
 app screen when displayed.
 */
class InterstitialViewController : UIViewController, SASInterstitialManagerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var loadInterstitialButton: UIButton!
    @IBOutlet weak var showInterstitialButton: UIButton!
    
    private lazy var interstitialManager: SASInterstitialManager = {
        // Creating an ad placement first
        let adPlacement = SASAdPlacement(
            siteId: Constants.interstitialSiteId,
            pageId: Constants.interstitialPageId,
            formatId: Constants.interstitialFormatId,
            keywordTargeting: Constants.interstitialKeywordTargeting
        )
        
        // If you are an inventory reseller, you must provide a Supply Chain Object.
        // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
        // adPlacement.supplyChainObjectString = "1.0,1!exchange1.com,1234,1,publisher,publisher.com"
        
        // You can also use a test placement during development (a placement that will always
        // deliver an ad from a chosen format).
        // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!

        // let adPlacement = SASAdPlacement(testAd: .interstitialHTML)
        // let adPlacement = SASAdPlacement(testAd: .interstitialVideo)
        
        // The interstitial manager will be used to load and display the interstitial.
        // It is initialized using the previously created placement
        let interstitialManager = SASInterstitialManager(adPlacement: adPlacement)
        interstitialManager.delegate = self
        
        return interstitialManager
    }()
    
    // MARK: - View controller lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    // MARK: - Ad loading & showing logic
    
    @IBAction func loadInterstitialAction(_ sender: Any) {
        // The interstitial manager must first be used to load an ad.
        // Loading an ad will not automatically display it, check the method below for more info…
        interstitialManager.loadAd()
    }
    
    @IBAction func showInterstitialAction(_ sender: Any) {
        // Once an interstitial ad is loaded, you can show it using the interstitial manager.
        interstitialManager.show(from: self)
        
        // Note that you can check if an ad is actually available using the interstitial
        // manager's delegate methods or using the `adStatus` property.
        // Attempting to show the interstitial if no ad is ready will triggers an error!
    }
    
    private func updateUI() {
        // Using the `adStatus` property to assess if the interstitial is ready to be displayed…
        showInterstitialButton.isEnabled = interstitialManager.adStatus == .ready
    }
    
    // MARK: - Interstitial manager delegate
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didLoadWith adInfo: SASAdInfo) {
        updateUI()
        print("Interstial ad loaded with info: \(adInfo)")
    }
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didFailToLoad error: Error) {
        updateUI()
        print("Interstial did fail to load with error: \(error)")
    }
    
    func interstitialManagerDidShow(_ interstitialManager: SASInterstitialManager) {
        updateUI()
        print("Interstial ad was shown")
    }
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didFailToShow error: Error) {
        updateUI()
        print("Interstial did fail to show with error: \(error)")
    }
    
    func interstitialManagerDidClose(_ interstitialManager: SASInterstitialManager) {
        updateUI()
        print("Interstial ad was closed")
    }
    
    func interstitialManagerClicked(_ interstitialManager: SASInterstitialManager) {
        print("Interstial ad was clicked")
    }
    
    func interstitialManagerWillStartAudioPlayback(_ interstitialManager: SASInterstitialManager) {
        print("Interstitial video ad will start to play audio")

        // Equativ Display SDK is notifying your app that it will play audio. You could optionally
        // pause music and/or manipulate your audio session category depending on your apps design.
    }

    func interstitialManagerDidStopAudioPlayback(_ interstitialManager: SASInterstitialManager) {
        print("Interstitial video ad did stop to play audio")

        // Equativ Display SDK is notifying your app that it has stopped playing audio. Depending
        // on your apps design, you could resume music here and/or restore your audio session category.
    }
}
