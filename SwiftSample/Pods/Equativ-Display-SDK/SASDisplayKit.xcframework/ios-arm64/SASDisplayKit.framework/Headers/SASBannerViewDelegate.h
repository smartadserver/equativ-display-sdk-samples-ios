//
//  SASBannerViewDelegate.h
//  SASDisplayKit
//
//  Created by Loïc GIRON DIT METAZ on 24/03/2022.
//  Copyright © 2022 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SASBannerView;
@class SASAdInfo;

/**
 SASBannerView delegate.
 */
@protocol SASBannerViewDelegate <NSObject>

@required

/**
 Called when the banner view has loaded an ad successfully.
 
 @param bannerView The instance of SASBannerView calling the delegate.
 @param adInfo The instance of SASAdInfo related to the loaded ad.
 */
- (void)bannerView:(SASBannerView *)bannerView didLoadWithInfo:(SASAdInfo *)adInfo;

/**
 Called when the banner view fails to load the ad.
 
 @param bannerView The instance of SASBannerView calling the delegate.
 @param error The error preventing the banner from being loaded.
 */
- (void)bannerView:(SASBannerView *)bannerView didFailToLoadWithError:(NSError *)error NS_SWIFT_NAME( bannerView(_:didFailToLoad:) );

@optional

/**
 Called when a valid click is registered on the banner view.
 
 @param bannerView The instance of SASBannerView calling the delegate.
 */
- (void)bannerViewClicked:(SASBannerView *)bannerView;

@end

NS_ASSUME_NONNULL_END
