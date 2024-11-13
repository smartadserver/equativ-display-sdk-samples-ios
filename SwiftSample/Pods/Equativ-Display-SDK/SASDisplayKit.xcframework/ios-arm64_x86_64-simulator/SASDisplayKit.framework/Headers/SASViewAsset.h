//
//  SASViewAsset.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 22/07/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Object representing all the assets linked to a view, typically a subview of a native ad.
 */
@interface SASViewAsset : NSObject

/// The view representing this asset if any, nil otherwise.
@property (readonly, nullable) UIView *view;

/// The URL representing this asset if any, nil otherwise.
@property (readonly, nullable) NSURL *url;

/// The width of the asset if available, nil otherwise.
@property (readonly, nullable) NSNumber *width;

/// The height of the asset if available, nil otherwise.
@property (readonly, nullable) NSNumber *height;

/**
 Initialize a new instance of SASViewAsset.
 
 @note A view asset must have at least a view or an URL, otherwise this initializer will return nil.
 
 @param view The view representing this asset if any, nil otherwise.
 @param url The URL representing this asset if any, nil otherwise.
 @param width The width of the asset if available, nil otherwise.
 @param height The height of the asset if available, nil otherwise.
 @return An initialized instance of SASViewAsset
 */
- (nullable instancetype)initWithView:(nullable UIView *)view
                                  url:(nullable NSURL *)url
                                width:(nullable NSNumber *)width
                               height:(nullable NSNumber *)height NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
