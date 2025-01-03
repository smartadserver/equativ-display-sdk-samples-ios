//
//  SASInterstitialManager.h
//  SASDisplayKit
//
//  Created by Loïc GIRON DIT METAZ on 20/07/2022.
//  Copyright © 2022 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASInterstitialManagerDelegate.h>
#import <SASDisplayKit/SASAdPlacement.h>
#import <SASDisplayKit/SASBiddingAdResponse.h>
#import <SASDisplayKit/SASAdStatus.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A class that loads and shows an interstitial ad.
 */
@interface SASInterstitialManager : NSObject

/// The interstitial manager delegate if any, nil otherwise.
@property (weak, nullable) id<SASInterstitialManagerDelegate> delegate;

/// The current status of the ad.
@property (readonly) SASAdStatus adStatus;

/// The ad placement used to load the ad.
@property (readonly) SASAdPlacement *adPlacement;

/**
 Initialize a new instance of SASInterstitialManager.
 
 @param adPlacement The ad placement used to load the ad.
 @return An initialized instance of SASInterstitialManager.
 */
- (instancetype)initWithAdPlacement:(SASAdPlacement *)adPlacement NS_DESIGNATED_INITIALIZER;

/**
 Initialize a new instance of SASInterstitialManager using a bidding ad response.
 
 You can create a bidding ad response using the SASBiddingManager class.
 
 @note A bidding ad response can only be used once: you must recreate a new instance of the interstitial manager
 with a new bidding ad response after each 'loadAd' call.

 @param biddingAdResponse The bidding ad response that must be rendered.
 @return An initialized instance of SASInterstitialManager.
 */
- (instancetype)initWithBiddingAdResponse:(SASBiddingAdResponse *)biddingAdResponse NS_DESIGNATED_INITIALIZER;

/**
 Attempt to load an ad using the provided ad placement.
 */
- (void)loadAd;

/**
 Show the interstitial if the ad status is 'SASAdStatusReady'.
 
 @param viewController The view controller in which the interstitial view controller should be pushed.
 */
- (void)showFromViewController:(UIViewController *)viewController;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
