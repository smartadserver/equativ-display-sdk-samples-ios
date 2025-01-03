//
//  SASBiddingAdPrice.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 29/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASBiddingCurrency.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model class representing a bidding ad price.
 */
@interface SASBiddingAdPrice : NSObject

/// The CPM (as double) of the bidding ad.
@property (readonly) double cpm;

/// The currency of the cpm.
@property (readonly) SASBiddingCurrency currency;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
