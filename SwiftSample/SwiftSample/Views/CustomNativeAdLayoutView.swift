//
//  CustomNativeAdLayoutView.swift
//  SwiftSample
//
//  Created by Loic GIRON DIT METAZ on 24/09/2024.
//

import UIKit
import SASDisplayKit

/**
 This class is an example of native ad custom layout.
 It is created using pure Swift code, but it could also be initialized from a XIB file as well.
 
 Note that not all native contains the same info to display, it is important to create
 flexible layout that react properly when some information are not filled in the native ad assets.
 
 In this example, we are building a flexible layout using UIStackView instances then we will
 hide the unused views when creating the 'native ad view binder' from the 'native ad view assets'
 in the dedicated method.
 */
class CustomNativeAdLayoutView : UIView {
    
    private let titleLabel = UILabel(frame: .zero)
    private let bodyLabel = UILabel(frame: .zero)
    private let callToActionButton = UIButton(frame: .zero)
    private let advertiserLabel = UILabel(frame: .zero)
    private let ratingBarView = SASRatingBarView(frame: .zero) // Note: this sample uses a SASRatingBarView to display the rating, but any view implementing the SASRatingBar protocol can be used instead
    private let iconImageView = UIImageView(frame: .zero)
    private let mainView = UIView(frame: .zero)
    private let customLayoutLabelTop = UILabel(frame: .zero)
    private let customLayoutLabelBottom = UILabel(frame: .zero)

    private let mainVerticalStackView = UIStackView(frame: .zero)
    private let titleAndIconHorizontalStackView = UIStackView(frame: .zero)
    private let titleVerticalStackView = UIStackView(frame: .zero)
    
    /**
     Some constants to customize the appearance of the custome native ad layout.
     */
    private class Constants {
        static let mainMargin: CGFloat = 10
        static let internalMargin: CGFloat = 10
        static let callToActionButtonHeight: CGFloat = 40
        static let ratingBarHeight: CGFloat = 15
        static let iconSize: CGFloat = 60
        static let titleStackSpacing: CGFloat = 2
        static let titleFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        static let advertiserFont = UIFont.systemFont(ofSize: 11, weight: .light)
        static let bodyFont = UIFont.systemFont(ofSize: 13, weight: .light)
        static let customLabelFont = UIFont.systemFont(ofSize: 14, weight: .thin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
    }
    
    /**
     This method is used to configure the appearance of our custom layout.
     You can replace it by the XIB file if you want.
     */
    private func configureLayout() {
        // Configuring views for constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        advertiserLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingBarView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        titleAndIconHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        titleVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        customLayoutLabelTop.translatesAutoresizingMaskIntoConstraints = false
        customLayoutLabelBottom.translatesAutoresizingMaskIntoConstraints = false

        // Configuring view styles
        titleLabel.font = Constants.titleFont
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        
        advertiserLabel.font = Constants.advertiserFont
        advertiserLabel.numberOfLines = 1
        advertiserLabel.lineBreakMode = .byTruncatingTail
        
        bodyLabel.font = Constants.bodyFont
        bodyLabel.numberOfLines = 0
        
        customLayoutLabelTop.text = "↓↓↓ CUSTOM LAYOUT ↓↓↓"
        customLayoutLabelTop.font = Constants.customLabelFont
        customLayoutLabelTop.textAlignment = .center
        
        customLayoutLabelBottom.text = "↑↑↑ CUSTOM LAYOUT ↑↑↑"
        customLayoutLabelBottom.font = Constants.customLabelFont
        customLayoutLabelBottom.textAlignment = .center
        
        if #available(iOS 15.0, *) {
            callToActionButton.configuration = .borderedProminent()
        }
        
        // Configuring view layout
        titleVerticalStackView.axis = .vertical
        titleVerticalStackView.spacing = Constants.titleStackSpacing
        
        titleVerticalStackView.addArrangedSubview(titleLabel)
        titleVerticalStackView.addArrangedSubview(advertiserLabel)
        titleVerticalStackView.addArrangedSubview(UIView(frame: .zero))
        titleVerticalStackView.addArrangedSubview(ratingBarView)
        
        NSLayoutConstraint.activate([
            ratingBarView.heightAnchor.constraint(equalToConstant: Constants.internalMargin)
        ])
        
        titleAndIconHorizontalStackView.axis = .horizontal
        titleAndIconHorizontalStackView.spacing = Constants.internalMargin
        
        titleAndIconHorizontalStackView.addArrangedSubview(iconImageView)
        titleAndIconHorizontalStackView.addArrangedSubview(titleVerticalStackView)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
        ])
        
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.spacing = Constants.internalMargin
        
        mainVerticalStackView.addArrangedSubview(customLayoutLabelTop)
        mainVerticalStackView.addArrangedSubview(mainView)
        mainVerticalStackView.addArrangedSubview(titleAndIconHorizontalStackView)
        mainVerticalStackView.addArrangedSubview(bodyLabel)
        mainVerticalStackView.addArrangedSubview(callToActionButton)
        mainVerticalStackView.addArrangedSubview(customLayoutLabelBottom)

        NSLayoutConstraint.activate([
            callToActionButton.heightAnchor.constraint(equalToConstant: Constants.callToActionButtonHeight)
        ])
        
        addSubview(mainVerticalStackView)
        
        NSLayoutConstraint.activate([
            mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.mainMargin),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.mainMargin),
            mainVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.mainMargin),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.mainMargin),
        ])
    }
    
    /**
     This method shows how you can create a 'native ad view binder' for this custom layout from
     the 'native ad assets' returned after a successful native ad loading.
     */
    func nativeAdViewBinder(nativeAdAssets: SASNativeAdAssets) -> SASNativeAdViewBinder {
        
        // A native a view binder builder must first be created:
        // this builder takes the 'base' view as parameter, aka the view that acts as superview
        // for all the other views that are going to display the native ad.
        let builder = SASNativeAdViewBinderBuilder(baseView: self)
        
        // Each view that is going to display part of the native ad must then be declared to the builder
        builder.withTitleLabel(titleLabel)
        builder.withBodyLabel(bodyLabel)
        builder.withCallToActionButton(callToActionButton)
        builder.withAdvertiserLabel(advertiserLabel)
        builder.withRatingBar(ratingBarView)
        builder.withIconView(iconImageView)
        builder.withMainView(mainView)
        
        // Views that are not going to display anything must be hidden or removed from the layout:
        // the Equativ Display SDK will be in charge to fill all the views declared to the builder, but
        // it will never modify the layout or remove views…
        titleLabel.isHidden = nativeAdAssets.title == nil
        bodyLabel.isHidden = nativeAdAssets.body == nil
        callToActionButton.isHidden = nativeAdAssets.callToAction == nil
        advertiserLabel.isHidden = nativeAdAssets.advertiser == nil
        ratingBarView.isHidden = nativeAdAssets.rating == nil
        iconImageView.isHidden = nativeAdAssets.iconImage == nil
        mainView.isHidden = nativeAdAssets.mainView == nil
        
        // You can use information provided in the native ad assets instance to customize the appearance
        // of some of the views:
        // For instance you can use the size of the main view asset if available to ensure that the view of
        // your layout will always have the proper aspect ratio.
        if let widthValue = nativeAdAssets.mainView?.width,
           let heightValue = nativeAdAssets.mainView?.height,
           widthValue.floatValue > 0.0 && heightValue.floatValue > 0.0 {
            let ratio = CGFloat(widthValue.floatValue) / CGFloat(heightValue.floatValue)
            let ratioConstaint = mainView.widthAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: ratio)
            ratioConstaint.priority = .defaultHigh
            NSLayoutConstraint.activate([ratioConstaint])
        }
        
        // The builder can then be use to build the final instance of the 'native ad view binder'
        return builder.build()
    }
}
