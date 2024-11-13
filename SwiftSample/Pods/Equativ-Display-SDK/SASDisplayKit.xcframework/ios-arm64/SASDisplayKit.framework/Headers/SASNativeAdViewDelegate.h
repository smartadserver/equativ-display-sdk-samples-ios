//
//  SASNativeAdViewDelegate.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 08/07/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SASNativeAdView;
@class SASAdInfo;
@class SASNativeAdAssets;
@class SASNativeAdViewBinder;

/**
 SASNativeAdView delegate.
 */
@protocol SASNativeAdViewDelegate <NSObject>

@required

/**
 Called when the native ad view has loaded an ad successfully.
 
 @param nativeAdView The instance of SASNativeAdView calling the delegate.
 @param adInfo The instance of SASAdInfo related to the loaded native ad.
 @param nativeAdAssets The assets of the loaded native ad that are going to be rendered by the native ad view.
 */
- (void)nativeAdView:(SASNativeAdView *)nativeAdView didLoadWithInfo:(SASAdInfo *)adInfo nativeAdAssets:(SASNativeAdAssets *)nativeAdAssets;

/**
 Called when the native ad view fails to load the ad.
 
 @param nativeAdView The instance of SASNativeAdView calling the delegate.
 @param error The error preventing the native ad from being loaded.
 */
- (void)nativeAdView:(SASNativeAdView *)nativeAdView didFailToLoadWithError:(NSError *)error NS_SWIFT_NAME( nativeAdView(_:didFailToLoad:) );

@optional

/**
 Called when a valid click is registered on the native ad view.
 
 @param nativeAdView The instance of SASNativeAdView calling the delegate.
 */
- (void)nativeAdViewClicked:(SASNativeAdView *)nativeAdView;

/**
 Called when the native ad requests to be closed.
 
 @note Some ad formats might want to close the native ad by themself. It is
 the app responsability to actually close the native ad, aka to remove it from the views' hierarchy. If the
 app does nothing or does not implement this delegate, the ad will not be closed.
 
 @param nativeAdView The instance of SASNativeAdView requesting to be closed.
 */
- (void)nativeAdViewDidRequestClose:(SASNativeAdView *)nativeAdView;

/**
 Called when a custom layout is requested in order to render the native ad.

 Implementing this method is optional: default layouts will be used if this method is not implemented or if the method returns nil.
 
 @param nativeAdView The instance of SASNativeAdView calling the delegate.
 @param nativeAdAssets A native ad assets instance related to this ad that can be used to customize the layout if needed. Please note
 that the SDK will not update your layout, therefore missing assets can lead to empty spaces. It is your app responsibility to adjust
 your layout to avoid blank spaces.
 @return A native ad view binder instance that will be used by the SDK to render the ad, or nil to use the default layout of the SDK.
 */
- (nullable SASNativeAdViewBinder *)nativeAdView:(SASNativeAdView *)nativeAdView didRequestBinderForNativeAdAssets:(SASNativeAdAssets *)nativeAdAssets;

@end

NS_ASSUME_NONNULL_END
