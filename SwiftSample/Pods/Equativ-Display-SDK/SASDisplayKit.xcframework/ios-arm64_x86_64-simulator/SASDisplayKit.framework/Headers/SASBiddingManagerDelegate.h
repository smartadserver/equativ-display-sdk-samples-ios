//
//  SASBiddingManagerDelegate.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 30/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SASBiddingManager;
@class SASBiddingAdResponse;

/**
 SASBiddingManager delegate.
 */
@protocol SASBiddingManagerDelegate <NSObject>

@required

/**
 Called when the bidding manager has loaded an ad response successfully.
 
 @note The ad response can be displayed using an instance of SASBannerView or SASInterstitialManager depending
 on the requestion bidding ad format type.
 
 @param biddingManager The instance of SASBiddingManager calling the delegate.
 @param biddingAdResponse The ad response loaded by the bidding manager.
 */
- (void)biddingManager:(SASBiddingManager *)biddingManager didLoadWithBiddingAdResponse:(SASBiddingAdResponse *)biddingAdResponse;

/**
 Called when the bidding manager fails to load the ad.
 
 @param biddingManager The instance of SASBiddingManager calling the delegate.
 @param error The error preventing the bidding ad from being loaded.
 */
- (void)biddingManager:(SASBiddingManager *)biddingManager didFailToLoadWithError:(NSError *)error NS_SWIFT_NAME( biddingManager(_:didFailToLoad:) );

@end

NS_ASSUME_NONNULL_END
