//
//  SASDigitalServiceActConfigTransparency.h
//  SASDisplayKit
//
//  Created by Guillaume LAUBIER on 14/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model class centralizing useful Digital Service Act Transparency information.
 */
@interface SASDigitalServiceActConfigTransparency : NSObject

/// The domain of the entity that applied user parameters.
@property (readonly) NSString *domain;

/// An array of integer (as NSNumber) representing the applied user parameters.
/// Please refer to this IAB documentation https://github.com/InteractiveAdvertisingBureau/openrtb/blob/main/extensions/community_extensions/dsa_transparency.md#user_parameters
@property (readonly) NSArray<NSNumber *> *DSAParams;

/**
 Initializes a new instance of SASDigitalServiceActConfigTransparency.
 
 @param domain The domain of the entity that applied user parameters.
 @param DSAParams An array of integer as NSNumber representing the applied user parameters.
 
 @return An initialized instance of SASDigitalServiceActTransparency.
 */
- (instancetype)initWithDomain:(NSString *)domain DSAParams:(NSArray<NSNumber *> *)DSAParams;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
