//
//  SASMediationInterstitialAdapterDelegate.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 03/06/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASMediationInterstitialAdapter;

/**
 SASMediationInterstitialAdapter delegate.
 */
@protocol SASMediationInterstitialAdapterDelegate <NSObject>

/**
 Called when the underlying mediation ad has loaded successfully.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 */
- (void)mediationInterstitialAdapterDidLoadAd:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter;

/**
 Called when the underlying mediation ad has failed to load.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 @param error The error preventing the underlying mediation ad from being loaded.
 @param noFill YES if the ad could not be loaded because of 'no ad / no fill', NO for any other loading error.
 */
- (void)mediationInterstitialAdapter:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter 
              didFailToLoadWithError:(NSError *)error
                              noFill:(BOOL)noFill;

/**
 Called when the underlying mediation ad has been clicked.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 */
- (void)mediationInterstitialAdapterDidReceiveAdClickEvent:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter;

/**
 Called when the underlying mediation ad has been shown.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 */
- (void)mediationInterstitialAdapterDidShow:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter;

/**
 Called when the underlying mediation ad fails to be shown.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 @param error The error preventing the interstitial ad from being shown.
 */
- (void)mediationInterstitialAdapter:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter
              didFailToShowWithError:(NSError *)error;

/**
 Called when the underlying mediation ad has been closed.
 
 @param mediationInterstitialAdapter The instance of SASMediationInterstitialAdapter calling the delegate.
 */
- (void)mediationInterstitialAdapterDidClose:(id<SASMediationInterstitialAdapter>)mediationInterstitialAdapter;

@end

NS_ASSUME_NONNULL_END
