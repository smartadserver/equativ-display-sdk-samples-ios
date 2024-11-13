//
//  SASNativeAdViewBinderBuilder.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 08/08/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SASRatingBar;

@class SASNativeAdViewBinder;

/**
 Builder than can be use to instantiate a `SASNativeAdViewBinder` instance.
 */
@interface SASNativeAdViewBinderBuilder : NSObject

/**
 Initialize a new instance of SASNativeAdViewBinderBuilder.
 
 @param baseView The view containing of the other views of the native ad.
 @return An initialized instance of SASNativeAdViewBinderBuilder.
 */
- (instancetype)initWithBaseView:(UIView *)baseView NS_DESIGNATED_INITIALIZER;

/**
 Build an instance of SASNativeAdViewBinder.
 
 @return An initialized instance of SASNativeAdViewBinder.
 */
- (SASNativeAdViewBinder *)build;

/**
 Set the label displaying the ad title on the builder.
 
 @param titleLabel The label displaying the ad title.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withTitleLabel:(UILabel *)titleLabel;

/**
 Set the label displaying the ad body on the builder.
 
 @param bodyLabel The label displaying the ad body.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withBodyLabel:(UILabel *)bodyLabel;

/**
 Set the button displaying the ad call to action on the builder.
 
 @param callToActionButton The button displaying the ad call to action.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withCallToActionButton:(UIButton *)callToActionButton;

/**
 Set the label displaying the ad advertiser on the builder.
 
 @param advertiserLabel The label displaying the ad advertiser.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withAdvertiserLabel:(UILabel *)advertiserLabel;

/**
 Set the rating bar displaying the ad rating on the builder.
 
 @param ratingBar The rating bar displaying the ad rating.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withRatingBar:(UIView<SASRatingBar> *)ratingBar;

/**
 Set the view displaying the ad icon on the builder.
 
 @param iconView The view displaying the ad icon.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withIconView:(UIView *)iconView;

/**
 Set the view displaying the ad main content on the builder.
 
 @param mainView The view displaying the ad main content.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withMainView:(UIView *)mainView;

/**
 Set the view that will contain the ad customer feedback button on the builder.
 
 @note Displaying the customer feedback button is mandatory. If no container is set,
 the customer feedback button will be added in the top right corner of the base view.

 @param customerFeedbackContainerView The view that will contain the ad customer feedback button.
 @return This instance of SASNativeAdViewBinderBuilder.
 */
- (SASNativeAdViewBinderBuilder *)withCustomerFeedbackContainerView:(UIView *)customerFeedbackContainerView;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
