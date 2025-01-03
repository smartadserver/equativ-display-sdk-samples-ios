//
//  InterstitialInAppBiddingViewController.swift
//  SwiftSample
//
//  Created by Loic GIRON DIT METAZ on 10/12/2024.
//

import UIKit
import SASDisplayKit

/**
 The purpose of this view controller is to display an in-app bidding interstitial.
 
 A bidding ad must first be requested using a 'bidding manager' and can then be rendered
 using a regular banner view instance.
 
 In an actual applications, displaying the bidding response or not would depend of the bidding
 responses received from other third party SDKs.
 */
class InterstitialInAppBiddingViewController : UIViewController, SASInterstitialManagerDelegate, SASBiddingManagerDelegate {
    
    // MARK: - Properties
    
    // The bidding manager instance that will be used to load a bidding ad response.
    private lazy var biddingManager: SASBiddingManager = SASBiddingManager(
        // Note that you must provide a placement, an ad format type, but also the currency you are using
        adPlacement: SASAdPlacement(siteId: 104808, pageId: 1160279, formatId: 85867, keywordTargeting: "interstitial-inapp-bidding"),
        formatType: .interstitial,
        currency: .EUR
    )
    
    // The interstitial manager instance that will be used to load & show the bidding ad response
    private var interstitialManager: SASInterstitialManager? = nil
    
    // The current bidding ad response if any, nil otherwise.
    private var currentBiddingAdResponse: SASBiddingAdResponse? = nil
    
    private var isBiddingManagerLoading = false

    @IBOutlet weak var loadAndRenderBiddingAdButton: UIButton!
    @IBOutlet weak var showBiddingAdButton: UIButton!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadAndRenderBiddingAdAction(_ sender: Any) {
        loadBiddingAd()
    }
    
    @IBAction func showBiddingAdAction(_ sender: Any) {
        showBiddingAd()
    }
    
    private func updateUIStatus() {
        loadAndRenderBiddingAdButton.isEnabled = !isBiddingManagerLoading && !isReadyToShow
        showBiddingAdButton.isEnabled = isReadyToShow
        
        if isBiddingManagerLoading {
            loadingStatusLabel.text = "loading a bidding ad…"
        } else if let biddingAdPrice = currentBiddingAdResponse?.price {
            loadingStatusLabel.text = "bidding response: \(biddingAdPrice)"
        } else {
            loadingStatusLabel.text = "(no bidding ad response loaded)"
        }
    }
    
    // MARK: - Bidder manager lifecycle
    
    func loadBiddingAd() {
        isBiddingManagerLoading = true
        currentBiddingAdResponse = nil
        
        // Loading a bidding ad response using the bidding manager.
        biddingManager.delegate = self
        biddingManager.loadAd()
                
        updateUIStatus()
    }
    
    var isReadyToShow: Bool {
        if let interstitialManager = interstitialManager {
            return interstitialManager.adStatus == .ready
        } else {
            return false
        }
    }

    // MARK: - Interstitial manager lifecycle
    
    func renderBiddingAd() {
        if let biddingAdResponse = currentBiddingAdResponse {
            // We use an interstitial manager to display the bidding response retrieved earlier.
            //
            // Note: in an actual application, you would load Equative bidding ad response only if it
            // better than responses you got from other third party SDKs.
            //
            // You can check the CPM associated with the bidding ad response by checking:
            // - biddingAdResponse.price.cpm
            // - biddingAdResponse.price.currency
            //
            // If you decide not to use the bidding ad response, you can simply discard it.
            interstitialManager = SASInterstitialManager(biddingAdResponse: biddingAdResponse)
            interstitialManager?.delegate = self
            interstitialManager?.loadAd()
            
            // Note that each bidding ad response can only be used once!
        }
        
        updateUIStatus()
    }

    func showBiddingAd() {
        // In this sample, we display the interstitial as soon as it is loaded.
        // But it is possible to display it later, like on regular interstitial integrations.
        interstitialManager?.show(from: self)

        updateUIStatus()
    }
    
    // MARK: - Bidding manager delegate
    
    func biddingManager(_ biddingManager: SASBiddingManager, didLoadWith biddingAdResponse: SASBiddingAdResponse) {
        print("Bidding manager did load with bidding ad response: \(biddingAdResponse)")
        
        currentBiddingAdResponse = biddingAdResponse
        updateUIStatus()

        // A bidding ad response has been received.
        renderBiddingAd()
    }
    
    func biddingManager(_ biddingManager: SASBiddingManager, didFailToLoad error: any Error) {
        print("Bidding ad failed to load with error: \(error)")
        
        isBiddingManagerLoading = false
        currentBiddingAdResponse = nil
        updateUIStatus()
    }

    // MARK: - Interstitial manager delegate
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didLoadWith adInfo: SASAdInfo) {
        print("Interstitial manager did load with info: \(adInfo)")
        
        isBiddingManagerLoading = false
        updateUIStatus()
    }
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didFailToLoad error: any Error) {
        print("Interstitial manager did fail to load with error: \(error)")
        
        isBiddingManagerLoading = false
        updateUIStatus()
    }
    
    func interstitialManagerDidShow(_ interstitialManager: SASInterstitialManager) {
        print("Interstitial manager did show")
        
        currentBiddingAdResponse = nil
        updateUIStatus()
    }
    
    func interstitialManager(_ interstitialManager: SASInterstitialManager, didFailToShow error: any Error) {
        print("Interstitial manager did fail to show with error: \(error)")
        
        currentBiddingAdResponse = nil
        updateUIStatus()
    }
}
