//
//  SASAdInfo.h
//  SASDisplayKit
//
//  Created by Guillaume Laubier on 18/09/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SASAdProgrammaticInfo;
@class SASAdDigitalServiceActInfo;

/// Model class centralizing useful information for publishers.
@interface SASAdInfo : NSObject

/// The insertion ID corresponding to this ad if available, nil otherwise.
@property (readonly, nullable) NSString *insertionID;

/// The aspect ratio of the ad if available, nil otherwise. This NSNumber contains a Float. Especially useful for banner format, you can easily compute the correct height of your banner by dividing your desired width by this aspectRatio.
@property (readonly, nullable) NSNumber *aspectRatio;

/// The name of the mediation SDK which is currently displaying the ad. Will be available only in a mediation ad call, and nil otherwise.
@property (readonly, nullable) NSString *mediationSDKName;

/// All programmatic info corresponding to this ad if available, nil otherwise.
@property (readonly, nullable) SASAdProgrammaticInfo *programmaticInfo;

/// All digital service act info corresponding to this ad if available, nil otherwise.
@property (readonly, nullable) SASAdDigitalServiceActInfo *digitalServiceActInfo;

/// Dictionary containing all extra parameters of the ad that is not already handled by a dedicated property.
@property (readonly) NSDictionary<NSString *, NSObject *> *extraParameters;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
