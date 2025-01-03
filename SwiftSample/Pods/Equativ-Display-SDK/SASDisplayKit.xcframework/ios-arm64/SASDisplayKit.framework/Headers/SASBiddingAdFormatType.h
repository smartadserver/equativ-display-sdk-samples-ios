//
//  SASBiddingAdFormatType.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 29/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Enumeration of the ad format compatible with in-app bidding.
typedef NS_ENUM(NSUInteger, SASBiddingAdFormatType) {
    
    /// Banner format.
    SASBiddingAdFormatTypeBanner,
    
    /// Interstitial format.
    SASBiddingAdFormatTypeInterstitial,
    
    /// Unknown format.
    SASBiddingAdFormatTypeUnknown,
    
};

NS_ASSUME_NONNULL_END
