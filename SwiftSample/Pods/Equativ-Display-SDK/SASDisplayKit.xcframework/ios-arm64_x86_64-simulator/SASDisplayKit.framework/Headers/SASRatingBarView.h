//
//  SASRatingBarView.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 12/08/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 View used to display a rating using star symbols.
 
 @note This view can only display values between 0.0 and 5.0, by 0.5 increments.
 */
@interface SASRatingBarView : UIView <SASRatingBar>

@end

NS_ASSUME_NONNULL_END
