//
//  SASBiddingAdResponse.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 30/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASBiddingAdFormatType.h>

NS_ASSUME_NONNULL_BEGIN

@class SASAdPlacement;
@class SASBiddingAdPrice;

/**
 Model class representing a bidding ad response.
 */
@interface SASBiddingAdResponse : NSObject

/// YES if this bidding ad response has already been consumed, NO otherwise.
///
/// @note A bidding ad can only be consumed once.
@property (readonly, getter=isConsumed) BOOL consumed;

/// The ad placement used to get this bidding ad response.
@property (readonly) SASAdPlacement *adPlacement;

/// The price of the ad related to this bidding ad response.
@property (readonly) SASBiddingAdPrice *price;

/// The bidding ad format related to this bidding ad response.
@property (readonly) SASBiddingAdFormatType formatType;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
