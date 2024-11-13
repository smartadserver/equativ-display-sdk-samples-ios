//
//  NativeAdViewInTableViewController.swift
//  SwiftSample
//
//  Created by Loic GIRON DIT METAZ on 23/09/2024.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a native ad in a table view controller.
 
 The table view cell containing the ad will be resized automatically using constraints.
 */
class NativeAdViewInTableViewController: UITableViewController, SASNativeAdViewDelegate {
    
    private let AD_ROW_INDEX = 20
    private let TOTAL_NUMBER_OF_ROWS = 40
    
    // MARK: - Properties
    
    private lazy var nativeAdView = SASNativeAdView(frame: .zero)

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        
        setupNativeAdView()
        loadNativeAdView()
    }
    
    // MARK: - Ad loading logic
    
    private func setupNativeAdView() {
        // Adding the view controller as delegate
        nativeAdView.delegate = self
        
        // Adding the current view controller as modal parent view controller:
        // this is the controller the SDK will use if the ad needs to be expanded in a modal state
        nativeAdView.modalParentViewController = self
    }
    
    private func loadNativeAdView() {
        // Creating an ad placement first
        let adPlacement = SASAdPlacement(
            siteId: Constants.nativeAdWithIconAndCoverSiteId,
            pageId: Constants.nativeAdWithIconAndCoverPageId,
            formatId: Constants.nativeAdWithIconAndCoverFormatId,
            keywordTargeting: Constants.nativeAdWithIconAndCoverKeywordTargeting
        )
        
        // If you are an inventory reseller, you must provide a Supply Chain Object.
        // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
        // adPlacement.supplyChainObjectString = "1.0,1!exchange1.com,1234,1,publisher,publisher.com"
        
        // You can also use a test placement during development (a placement that will always
        // deliver an ad from a chosen format).
        // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
        
        // let adPlacement = SASAdPlacement(testAd: .nativeAdIcon)
        // let adPlacement = SASAdPlacement(testAd: .nativeAdIconAndCover)
        
        // Load the placement in the banner using the loadAd method
        nativeAdView.loadAd(with: adPlacement)
    }
    
    @IBAction func refreshControlAction(_ sender: Any) {
        loadNativeAdView()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view delegate & data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return TOTAL_NUMBER_OF_ROWS
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0:
            return dequeueHeaderCell()
        case AD_ROW_INDEX:
            return dequeueAdCell()
        default:
            return contentCell(indexPathRow: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view cell utils
    
    private func dequeueHeaderCell() -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "headerCell")!
    }
    
    private func dequeueAdCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adCell")!
        
        // Adding the native ad view to the cell
        cell.contentView.addSubview(nativeAdView)
        
        // Setting the native ad view constraints
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nativeAdView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            nativeAdView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            nativeAdView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            nativeAdView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
        
        // Note: while it is possible to integrate the native ad view using an aspect ratio constraints
        // as it is usually done for banner views, it is better to use an automatic table view row height.
        // The aspect ratio of a native ad view will indeed only be accurate if the ad is displayed using the
        // full width of the device and if no rotation happens after loading.
        
        return cell
    }
    
    private func contentCell(indexPathRow: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
        (cell.viewWithTag(1) as! UILabel).text = "\(indexPathRow)"
        return cell
    }
    
    // MARK: - Native ad view delegate
    
    func nativeAdView(_ nativeAdView: SASNativeAdView, didLoadWith adInfo: SASAdInfo, nativeAdAssets: SASNativeAdAssets) {
        print("Native ad loaded with info: \(adInfo)\nnative ad assets:\(nativeAdAssets)")
    }
    
    func nativeAdView(_ nativeAdView: SASNativeAdView, didFailToLoad error: any Error) {
        print("Native ad did fail to load with error: \(error)")
    }
    
    func nativeAdViewClicked(_ nativeAdView: SASNativeAdView) {
        print("Native ad was clicked")
    }
    
    func nativeAdView(_ nativeAdView: SASNativeAdView, didRequestBinderFor nativeAdAssets: SASNativeAdAssets) -> SASNativeAdViewBinder? {
        print("Native ad did request custom view binder for rendering")
        
        // This method is called when the Equativ Display SDK needs a layout in which render the native ad assets.
        // You can use it to return a custom layout that will be used to display the ad.
        
        // To use a custom layout, you must first create the view that will display the native ad:
//         let customNativeAdLayout = CustomNativeAdLayoutView(frame: .zero)
        
        // Then create a 'native ad view binder' so the Equativ Display SDK can display the assets of the native ad
        // in the right subviews of your layout.
        // You should also hide or remove views that are not going to be necessary as the SDK will not modify your layout.
        // Check the `CustomNativeAdLayoutView` class for more information on how to create the binder…
//         let binder = customNativeAdLayout.nativeAdViewBinder(nativeAdAssets: nativeAdAssets)
        
        // Finally, the binder must be returned to the SDK…
//         return binder
        
        // ---
        
        // Or you can simply return 'nil' which is the default behavior of this method if you do not implement it.
        // In that case, the Equativ Display SDK will automatically choose most suitable default layout to render
        // the native ad assets.
        
        return nil
    }
}
