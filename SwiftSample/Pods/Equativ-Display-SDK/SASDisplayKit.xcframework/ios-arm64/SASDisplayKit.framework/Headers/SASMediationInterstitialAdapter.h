//
//  SASMediationInterstitialAdapter.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 03/06/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASMediationInterstitialAdapterDelegate;

/**
 Protocol implemented by mediation adapters that load and show interstitial ads.
 */
@protocol SASMediationInterstitialAdapter <NSObject>

/// The mediation interstitial adapter delegate if any, nil otherwise.
@property (weak, nullable) id<SASMediationInterstitialAdapterDelegate> delegate;

/// The name of the mediated SDK.
@property (readonly) NSString *sdkName;

/// The version of the mediated SDK.
@property (readonly) NSString *sdkVersion;

/// The version of the mediation adapter.
@property (readonly) NSString *adapterVersion;

/**
 Load a mediation ad using a third party SDK.
 
 @note The mediation adapter must signal the success or the failure of the ad loading using the delegate to allow
 the mediation waterfall to work properly.
 
 @param serverSideParameters A string parsed in the ad response representing the data to pass to the mediation adapter.
 @param clientSideParameters A dictionary of client side parameters set by the publisher that can be forwarded to the third party SDK if any, nil otherwise.
 */
- (void)loadAdWithServerSideParameters:(NSString *)serverSideParameters
                  clientSideParameters:(nullable NSDictionary<NSString *, id> *)clientSideParameters;

/**
 Show the previously loaded interstitial ad.
 
 @param modalParentViewController The view controller that should be used as parent of the interstitial ad being shown.
 */
- (void)showWithModalParentViewController:(UIViewController *)modalParentViewController;

@end

NS_ASSUME_NONNULL_END
