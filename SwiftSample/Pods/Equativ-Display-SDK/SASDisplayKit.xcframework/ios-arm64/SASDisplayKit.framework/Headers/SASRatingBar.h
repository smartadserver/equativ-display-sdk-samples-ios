//
//  SASRatingBar.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 12/08/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol implemented by views that are able to display ratings.
 */
@protocol SASRatingBar <NSObject>

/// The rating that must be displayed by the rating bar (between 0.0 and 5.0).
@property (assign) double rating;

@end

NS_ASSUME_NONNULL_END
