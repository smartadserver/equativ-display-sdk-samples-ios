//
//  SASAdDigitalServiceActInfo.h
//  SASDisplayKit
//
//  Created by Guillaume LAUBIER on 02/04/2025.
//  Copyright © 2025 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASDigitalServiceActConfigAdRender.h>
#import <SASDisplayKit/SASDigitalServiceActConfigPubRender.h>
#import <SASDisplayKit/SASDigitalServiceActConfigTransparency.h>

NS_ASSUME_NONNULL_BEGIN

/// Model class centralizing useful digital service act information for publishers.
@interface SASAdDigitalServiceActInfo : NSObject

/// The behalf value received in DSA config.
@property (readonly) NSString *behalf;

/// The paid value received in DSA config.
@property (readonly) NSString *paid;

/// The adRender value received in DSA config.
@property (readonly) SASDigitalServiceActConfigAdRender adRender;

/// The pubRender value received in DSA config.
@property (readonly) SASDigitalServiceActConfigPubRender pubRender;

/// The array of transparency values received in DSA config.
@property (readonly) NSArray<SASDigitalServiceActConfigTransparency *> *transparency;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
