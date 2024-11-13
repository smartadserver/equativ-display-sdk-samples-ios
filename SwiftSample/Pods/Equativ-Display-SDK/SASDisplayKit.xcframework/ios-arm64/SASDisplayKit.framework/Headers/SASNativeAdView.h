//
//  SASNativeAdView.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 08/07/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASNativeAdViewDelegate;
@class SASAdPlacement;

/**
 A view that loads and displays a native ad creative.
 */
@interface SASNativeAdView : UIView

/// The native ad view delegate if any, nil otherwise.
@property (weak, nullable) id<SASNativeAdViewDelegate> delegate;

/// The modal parent view controller of the current native ad view.
///
/// This controller will be used as root controller by the SDK if it needs to display a fullscreen controller.
///
/// @note You should always set a valid modal parent view controller, otherwise most post-click interactions
/// will not be able to work properly (post-click modal, StoreKit, …).
@property (weak, nullable) UIViewController *modalParentViewController;

/// The last placement loaded in the native ad view if any, nil otherwise.
@property (readonly, nullable) SASAdPlacement *adPlacement;

/**
 Attempt to load an ad using the provided ad placement.
 
 @param adPlacement The ad placement used to load the ad.
 */
- (void)loadAdWithAdPlacement:(SASAdPlacement *)adPlacement;

/**
 Track the specified mediation view instead of this native ad view instance.
 
 Calling this method is useful for mediation scenarios where the primary SDK is in charge of rendering
 the native ad assets and where its own rendered view must be tracked for impression, viewability, clicks, …
 
 This method has no effect if the native ad view instance was already displayed (i.e. when it has been added
 to a superview after a successful loading) or the loadAd() method has not been called yet. The typical use
 is to call this method on a native ad view instance after it has successfully loaded but before it was added
 to any UI.
 
 @note Calling this method will immediately call the impression pixel of the ad.
 
 @param mediationView The mediation view that is used to perform the native ad rendering and must be tracked instead of this native ad view instance.
 */
- (void)trackMediationView:(UIView *)mediationView;

@end

NS_ASSUME_NONNULL_END
