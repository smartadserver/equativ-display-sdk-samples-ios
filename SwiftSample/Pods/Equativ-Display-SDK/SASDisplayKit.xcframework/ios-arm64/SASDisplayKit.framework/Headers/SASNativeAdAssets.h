//
//  SASNativeAdAssets.h
//  SASDisplayKitTests
//
//  Created by Loic GIRON DIT METAZ on 22/07/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SASViewAsset;

/**
 Object representing all the assets that will be rendered in a given native ad.
 */
@interface SASNativeAdAssets : NSObject

/// The title if available, nil otherwise.
@property (readonly, nullable) NSString *title;

/// The body if available, nil otherwise.
@property (readonly, nullable) NSString *body;

/// The 'call to action' text if available, nil otherwise.
@property (readonly, nullable) NSString *callToAction;

/// The advertiser name if available, nil otherwise.
@property (readonly, nullable) NSString *advertiser;

/// The rating associated to the adverised product if available, nil otherwise.
@property (readonly, nullable) NSNumber *rating;

/// The asset representing the icon of the ad if available, nil otherwise.
@property (readonly, nullable) SASViewAsset *iconImage;

/// The view asset representing the main view of the ad (typically a cover image or a media) if available, nil otherwise.
@property (readonly, nullable) SASViewAsset *mainView;

/**
 Initialize a new instance of SASNativeAdAssets.
 
 @param title The title if available, nil otherwise.
 @param body The body if available, nil otherwise.
 @param callToAction The 'call to action' text if available, nil otherwise.
 @param advertiser The advertiser name if available, nil otherwise.
 @param rating The rating associated to the adverised product if available, nil otherwise.
 @param iconImage The asset representing the icon of the ad if available, nil otherwise.
 @param mainView The view asset representing the main view of the ad if available, nil otherwise.
 @return An initialized instance of SASNativeAdAssets.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                         body:(nullable NSString *)body
                 callToAction:(nullable NSString *)callToAction
                   advertiser:(nullable NSString *)advertiser
                       rating:(nullable NSNumber *)rating
                    iconImage:(nullable SASViewAsset *)iconImage
                     mainView:(nullable SASViewAsset *)mainView NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
