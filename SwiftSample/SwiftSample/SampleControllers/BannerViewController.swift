//
//  BannerViewController.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 11/10/2023.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a simple banner.
 
 The banner will be resized programmatically using constraint depending on the aspect
 ratio of the ad loaded (or automatically hidden if there is no ad).
 */
class BannerViewController : UIViewController, SASBannerViewDelegate {
    
    // MARK: - Properties
    
    private lazy var bannerView: SASBannerView = SASBannerView(frame: .zero)
    
    private lazy var aspectRatioConstraint = NSLayoutConstraint()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBannerView()
        loadBannerView()
    }
    
    // MARK: - Banner view constraints
    
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
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func updateBannerAspectRatio(_ ratio: Float) {
        // Removing the previous constraints if any
        bannerView.removeConstraint(aspectRatioConstraint)
        
        // Adding the new constraint to the banner view
        aspectRatioConstraint = aspectRatioConstraint(view: bannerView, ratio: ratio)
        bannerView.addConstraint(aspectRatioConstraint)
    }
    
    private func aspectRatioConstraint(view: UIView, ratio: Float) -> NSLayoutConstraint {
        let ratio = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: CGFloat(ratio))
        ratio.priority = UILayoutPriority(rawValue: 999)
        return ratio
    }
    
    // MARK: - Ad loading logic
    
    private func loadBannerView() {
        // Setting the ratio constraint to 0 so the banner view is hidden while not displaying ads
        updateBannerAspectRatio(0)
        
        // Creating an ad placement first
        let adPlacement = SASAdPlacement(
            siteId: Constants.bannerSiteId,
            pageId: Constants.bannerPageId,
            formatId: Constants.bannerFormatId,
            keywordTargeting: Constants.bannerKeywordTargeting
        )
        
        // If you are an inventory reseller, you must provide a Supply Chain Object.
        // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
        // adPlacement.supplyChainObjectString = "1.0,1!exchange1.com,1234,1,publisher,publisher.com"
        
        // You can also use a test placement during development (a placement that will always
        // deliver an ad from a chosen format).
        // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
        
        // let adPlacement = SASAdPlacement(testAd: .bannerHTML)
        // let adPlacement = SASAdPlacement(testAd: .bannerVideo)
        // let adPlacement = SASAdPlacement(testAd: .bannerMRAIDExpand)
        
        // Note that starting with the Equativ Display SDK 8.3.0 you can also load native ad insertions
        // through the banner view. Try it by using our native ad test placements:
        
        // let adPlacement = SASAdPlacement(testAd: .nativeAdIcon)
        // let adPlacement = SASAdPlacement(testAd: .nativeAdIconAndCover)

        // Load the placement in the banner using the `loadAd` method
        bannerView.loadAd(with: adPlacement)
    }
    
    @IBAction func reloadBannerAction(_ sender: Any) {
        loadBannerView()
    }
    
    // MARK: - Banner view delegate
    
    func bannerView(_ bannerView: SASBannerView, didLoadWith adInfo: SASAdInfo) {
        print("Banner ad loaded with info: \(adInfo)")
        
        // Updating the banner view ratio constraint using the ad declared aspect ratio.
        //
        // Note: in some rare case, the aspect ratio might be 'nil'. You can use a default
        // aspect ratio in this case (we recommend '320/50' for a standard banner).
        let ratio = adInfo.aspectRatio?.floatValue ?? 320/50
        updateBannerAspectRatio(ratio)
    }
    
    func bannerView(_ bannerView: SASBannerView, didFailToLoad error: Error) {
        print("Banner did fail to load with error: \(error)")
        
        // Setting the ratio constraint to 0 so the banner view is hidden while not displaying ads
        updateBannerAspectRatio(0)
    }
    
    func bannerViewClicked(_ bannerView: SASBannerView) {
        print("Banner ad was clicked")
    }
    
    func bannerViewWillStartAudioPlayback(_ bannerView: SASBannerView) {
        print("Banner video ad will start to play audio")
        
        // Equativ Display SDK is notifying your app that it will play audio. You could optionally
        // pause music and/or manipulate your audio session category depending on your apps design.
    }
    
    func bannerViewDidStopAudioPlayback(_ bannerView: SASBannerView) {
        print("Banner video ad did stop to play audio")
        
        // Equativ Display SDK is notifying your app that it has stopped playing audio. Depending
        // on your apps design, you could resume music here and/or restore your audio session category.
    }
}
