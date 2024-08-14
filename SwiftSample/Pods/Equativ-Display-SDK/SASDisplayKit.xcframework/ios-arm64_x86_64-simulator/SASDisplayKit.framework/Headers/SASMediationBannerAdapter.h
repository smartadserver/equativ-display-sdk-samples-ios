//
//  SASMediationBannerAdapter.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 23/05/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASMediationBannerAdapterDelegate;

/**
 Protocol implemented by mediation adapters that load and return banner ads.
 */
@protocol SASMediationBannerAdapter <NSObject>

/// The mediation banner adapter delegate if any, nil otherwise.
@property (weak, nullable) id<SASMediationBannerAdapterDelegate> delegate;

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

@end

NS_ASSUME_NONNULL_END
