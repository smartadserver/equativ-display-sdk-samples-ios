//
//  BannerViewInTableViewController.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 11/10/2023.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a banner in a table view cell.
 
 The table view cell containing the ad will be resized programmatically using constraints
 depending on the aspect ratio of the ad displayed (or automatically hidden if there is no ad).
 */
class BannerViewInTableViewController : UITableViewController, SASBannerViewDelegate {
    
    private let AD_ROW_INDEX = 20
    private let TOTAL_NUMBER_OF_ROWS = 40
    
    // MARK: - Properties
    
    private lazy var bannerView: SASBannerView = SASBannerView(frame: .zero)
    private var bannerViewAspectRatio: Float = 0
    private var bannerViewConstraints: [NSLayoutConstraint] = []
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        
        setupBannerView()
        loadBannerView()
    }
    
    // MARK: - Ad loading logic
    
    private func setupBannerView() {
        // Adding the view controller as delegate
        bannerView.delegate = self
        
        // Adding the current view controller as modal parent view controller:
        // this is the controller the SDK will use if the ad needs to be expanded in a modal state
        bannerView.modalParentViewController = self
    }
    
    private func loadBannerView() {
        // Setting the ratio constraint to 0 so the banner view is hidden while not displaying ads
        updateBannerAspectRatio(0)
        
        // Creating an ad placement first
        let adPlacement = SASAdPlacement(
            siteId: Constants.bannerInTableViewSiteId,
            pageId: Constants.bannerInTableViewPageId,
            formatId: Constants.bannerInTableViewFormatId,
            keywordTargeting: Constants.bannerInTableViewKeywordTargeting
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
        
        // Load the placement in the banner using the loadAd method
        bannerView.loadAd(with: adPlacement)
    }
    
    private func updateBannerAspectRatio(_ ratio: Float) {
        // Storing the aspect ratio in order to set the banner view constraint properly
        bannerViewAspectRatio = ratio
        
        // Reloading the ad row to apply this new constraint immediately if the cell is visible
        tableView.reloadRows(at: [IndexPath(row: AD_ROW_INDEX, section: 0)], with: .automatic)
    }
    
    @IBAction func refreshControlAction(_ sender: Any) {
        loadBannerView()
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
        
        // Adding the banner view to the cell
        cell.contentView.addSubview(bannerView)
        
        // Removing previous banner view constraints if any
        bannerView.removeConstraints(bannerViewConstraints)
        
        // Setting the main banner constraints
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerViewConstraints = [
            bannerView.leadingAnchor.constraint(equalTo:cell.contentView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo:cell.contentView.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo:cell.contentView.topAnchor),
            bannerView.bottomAnchor.constraint(equalTo:cell.contentView.bottomAnchor),
            
            // In order to display any type of creative properly, add an height constraint based
            // on the ratio of the ad you are trying to display (or a 0 ratio if there is no ad)
            aspectRatioConstraint(view: bannerView, ratio: bannerViewAspectRatio)
        ]
        NSLayoutConstraint.activate(bannerViewConstraints)
        
        return cell
    }
    
    private func contentCell(indexPathRow: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
        (cell.viewWithTag(1) as! UILabel).text = "\(indexPathRow)"
        return cell
    }
    
    private func aspectRatioConstraint(view: UIView, ratio: Float) -> NSLayoutConstraint {
        let ratio = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: CGFloat(ratio))
        ratio.priority = UILayoutPriority(rawValue: 999)
        return ratio
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
}
