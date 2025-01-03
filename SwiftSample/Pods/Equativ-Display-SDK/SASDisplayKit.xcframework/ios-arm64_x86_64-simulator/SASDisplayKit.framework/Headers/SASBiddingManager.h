//
//  SASBiddingManager.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 30/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASBiddingManagerDelegate.h>
#import <SASDisplayKit/SASBiddingCurrency.h>
#import <SASDisplayKit/SASBiddingAdFormatType.h>
#import <SASDisplayKit/SASAdPlacement.h>
#import <SASDisplayKit/SASAdStatus.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A class that loads a in-app bidding ad.
 */
@interface SASBiddingManager : NSObject

/// The bidding manager delegate if any, nil otherwise.
@property (weak, nullable) id<SASBiddingManagerDelegate> delegate;

/// The ad placement used to load the ad.
@property (readonly) SASAdPlacement *adPlacement;

/// The format type of the requested bidding ad.
@property (readonly) SASBiddingAdFormatType formatType;

/// The currency that must be used for the price of the bidding ad.
@property (readonly) SASBiddingCurrency currency;

/**
 Initialize a new instance of SASBiddingManager.
 
 @param adPlacement The ad placement used to load the ad.
 @param formatType The format type of the requested bidding ad.
 @param currency The currency that must be used for the price of the bidding ad.
 @return An initialized instance of SASBiddingManager.
 */
- (instancetype)initWithAdPlacement:(SASAdPlacement *)adPlacement
                         formatType:(SASBiddingAdFormatType)formatType
                           currency:(SASBiddingCurrency)currency;

/**
 Attempt to load an ad using the provided ad placement.
 */
- (void)loadAd;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
