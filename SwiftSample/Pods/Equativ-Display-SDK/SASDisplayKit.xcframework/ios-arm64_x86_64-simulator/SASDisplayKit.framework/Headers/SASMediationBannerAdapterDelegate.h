//
//  SASMediationBannerAdapterDelegate.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 23/05/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASMediationBannerAdapter;

/**
 SASMediationBannerAdapter delegate.
 */
@protocol SASMediationBannerAdapterDelegate <NSObject>

/// The modal parent view controller of the current banner if any, nil otherwise.
///
/// @warning Do not cache this value as its value could change during the adapter lifetime.
@property (readonly, nullable) UIViewController *modalParentViewController;

/**
 Called when the underlying mediation ad has loaded successfully.
 
 @param mediationBannerAdapter The instance of SASMediationBannerAdapter calling the delegate.
 @param mediatedView The third party view displaying the ad.
 @param width The width of the loaded ad if available, nil otherwise.
 @param height The height of the loaded ad if available, nil otherwise.
 */
- (void)mediationBannerAdapter:(id<SASMediationBannerAdapter>)mediationBannerAdapter
     didLoadAdWithMediatedView:(UIView *)mediatedView
                         width:(nullable NSNumber *)width
                        height:(nullable NSNumber *)height;

/**
 Called when the underlying mediation ad has failed to load.
 
 @param mediationBannerAdapter The instance of SASMediationBannerAdapter calling the delegate.
 @param error The error preventing the underlying mediation ad from being loaded.
 @param noFill YES if the ad could not be loaded because of 'no ad / no fill', NO for any other loading error.
 */
- (void)mediationBannerAdapter:(id<SASMediationBannerAdapter>)mediationBannerAdapter
        didFailToLoadWithError:(NSError *)error
                        noFill:(BOOL)noFill;

/**
 Called when the underlying mediation ad has been clicked.
 
 @param mediationBannerAdapter The instance of SASMediationBannerAdapter calling the delegate.
 */
- (void)mediationBannerAdapterDidReceiveAdClickEvent:(id<SASMediationBannerAdapter>)mediationBannerAdapter;

/**
 Called when the underlying mediation ad has expanded.
 
 @param mediationBannerAdapter The instance of SASMediationBannerAdapter calling the delegate.
 */
- (void)mediationBannerAdapterDidReceiveAdExpandEvent:(id<SASMediationBannerAdapter>)mediationBannerAdapter;

/**
 Called when the underlying mediation ad has collapsed.
 
 @param mediationBannerAdapter The instance of SASMediationBannerAdapter calling the delegate.
 */
- (void)mediationBannerAdapterDidReceiveAdCollapseEvent:(id<SASMediationBannerAdapter>)mediationBannerAdapter;

@end

NS_ASSUME_NONNULL_END
