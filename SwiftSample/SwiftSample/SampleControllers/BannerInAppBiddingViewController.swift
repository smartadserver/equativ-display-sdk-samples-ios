//
//  BannerInAppBiddingViewController.swift
//  SwiftSample
//
//  Created by Loic GIRON DIT METAZ on 09/12/2024.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display an in-app bidding banner.
 
 A bidding ad must first be requested using a 'bidding manager' and can then be rendered
 using a regular banner view instance.
 
 In an actual applications, displaying the bidding response or not would depend of the bidding
 responses received from other third party SDKs.
 */
class BannerInAppBiddingViewController : UIViewController, SASBannerViewDelegate, SASBiddingManagerDelegate {
    
    // MARK: - Properties
    
    // The bidding manager instance that will be used to load a bidding ad response.
    private lazy var biddingManager: SASBiddingManager = SASBiddingManager(
        // Note that you must provide a placement, an ad format type, but also the currency you are using
        adPlacement: SASAdPlacement(siteId: 104808, pageId: 1160279, formatId: 85867, keywordTargeting: "banner-inapp-bidding"),
        formatType: .banner,
        currency: .EUR
    )
    
    // The banner view instance that will be used to render the bidding ad response.
    private lazy var bannerView: SASBannerView = SASBannerView(frame: .zero)
    
    // The current bidding ad response if any, nil otherwise.
    private var currentBiddingAdResponse: SASBiddingAdResponse? = nil
    
    private var isBiddingManagerLoading = false

    @IBOutlet weak var loadBiddingAdButton: UIButton!
    @IBOutlet weak var renderBiddingAdButton: UIButton!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerView()
        updateUIStatus()
    }

    @IBAction func loadBiddingAdAction(_ sender: Any) {
        loadBiddingAd()
    }
    
    @IBAction func renderBiddingAdAction(_ sender: Any) {
        renderBiddingAd()
    }
    
    private func updateUIStatus() {
        loadBiddingAdButton.isEnabled = !isBiddingManagerLoading && !hasValidBiddingAdResponse
        renderBiddingAdButton.isEnabled = hasValidBiddingAdResponse
        
        if isBiddingManagerLoading {
            loadingStatusLabel.text = "loading a bidding ad…"
        } else if let biddingAdPrice = currentBiddingAdResponse?.price {
            loadingStatusLabel.text = "bidding response: \(biddingAdPrice)"
        } else {
            loadingStatusLabel.text = "(no bidding ad response loaded)"
        }
    }
    
    // MARK: - Bidding manager lifecycle
    
    private func loadBiddingAd() {
        isBiddingManagerLoading = true
        currentBiddingAdResponse = nil
        
        // Loading a bidding ad response using the bidding manager.
        biddingManager.delegate = self
        biddingManager.loadAd()
                
        updateUIStatus()
    }
    
    var hasValidBiddingAdResponse: Bool {
        if let biddingAdResponse = currentBiddingAdResponse {
            // A bidding ad response is valid only if it has not been consumed already
            return !biddingAdResponse.isConsumed
        } else {
            return false
        }
    }
    
    // MARK: - Banner view lifecycle
    
    private func setupBannerView() {
        // Adding the view controller as delegate
        bannerView.delegate = self
        
        // Adding the current view controller as modal parent view controller:
        // this is the controller the SDK will use if the ad needs to be expanded in a modal state
        bannerView.modalParentViewController = self
        
        // Adding the ad view to the actual view of the controller
        view.addSubview(bannerView)
        
        // Setting the main banner constraints
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func renderBiddingAd() {
        if let biddingAdResponse = currentBiddingAdResponse {
            // We use our banner to display the bidding response retrieved earlier.
            //
            // Note: in an actual application, you would load Equativ bidding ad response only if it
            // better than responses you got from other third party SDKs.
            //
            // You can check the CPM associated with the bidding ad response by checking:
            // - biddingAdResponse.price.cpm
            // - biddingAdResponse.price.currency
            //
            // If you decide not to use the bidding ad response, you can simply discard it.
            bannerView.loadAd(with: biddingAdResponse)
            
            // Note that each bidding ad response can only be used once!
        }
        
        updateUIStatus()
    }
    
    // MARK: - Bidding manager delegate
    
    func biddingManager(_ biddingManager: SASBiddingManager, didLoadWith biddingAdResponse: SASBiddingAdResponse) {
        print("Bidding manager did load with bidding ad response: \(biddingAdResponse)")
        
        isBiddingManagerLoading = false
        currentBiddingAdResponse = biddingAdResponse
        updateUIStatus()

        // A bidding ad response has been received.
        // You can now load it into an ad view or discard it. See renderBiddingAd(_:) for more info.
    }
    
    func biddingManager(_ biddingManager: SASBiddingManager, didFailToLoad error: any Error) {
        print("Bidding ad failed to load with error: \(error)")
        
        isBiddingManagerLoading = false
        currentBiddingAdResponse = nil
        updateUIStatus()
    }
   
    // MARK: - Banner view delegate
    
    func bannerView(_ bannerView: SASBannerView, didLoadWith adInfo: SASAdInfo) {
        print("Banner ad loaded with info: \(adInfo)")
        
        currentBiddingAdResponse = nil
        updateUIStatus()
    }
    
    func bannerView(_ bannerView: SASBannerView, didFailToLoad error: any Error) {
        print("Banner did fail to load with error: \(error)")
        
        currentBiddingAdResponse = nil
        updateUIStatus()
    }
    
}
