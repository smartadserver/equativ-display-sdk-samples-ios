//
//  SASNativeAdViewBinder.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 08/08/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASRatingBar;

/**
 Class used to bind a view to a native ad.
 
 @note You cannot instantiate this class directly, you must use the
 `SASNativeAdViewBinderBuilder` class instead.
 */
@interface SASNativeAdViewBinder : NSObject

/// The view containing of the other views of the native ad.
@property (readonly) UIView *baseView;

/// The label displaying the ad title if any, nil otherwise.
@property (readonly, nullable) UILabel *titleLabel;

/// The label displaying the ad boy if any, nil otherwise.
@property (readonly, nullable) UILabel *bodyLabel;

/// The button displaying the ad call to action if any, nil otherwise.
@property (readonly, nullable) UIButton *callToActionButton;

/// The label displaying the ad advertiser if any, nil otherwise.
@property (readonly, nullable) UILabel *advertiserLabel;

/// The rating bar displaying the ad rating if any, nil otherwise.
///
/// @note You can use the SASRatingBarView or any third party view
/// implementing the SASRatingBar protocol.
@property (readonly, nullable) UIView<SASRatingBar> *ratingBar;

/// The view displaying the ad icon if any, nil otherwise.
@property (readonly, nullable) UIView *iconView;

/// The view displaying the ad main content if any, nil otherwise.
@property (readonly, nullable) UIView *mainView;

/// The view that will contain the ad customer feedback button if any, nil otherwise.
///
/// @note Displaying the customer feedback button is mandatory. If no container is set,
/// the customer feedback button will be added in the top right corner of the base view.
@property (readonly, nullable) UIView *customerFeedbackContainerView;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
