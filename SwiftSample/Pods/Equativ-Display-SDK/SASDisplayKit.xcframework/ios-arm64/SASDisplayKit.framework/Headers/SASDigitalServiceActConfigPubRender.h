//
//  SASDigitalServiceActConfigPubRender.h
//  SASDisplayKit
//
//  Created by Guillaume LAUBIER on 02/04/2025.
//  Copyright © 2025 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SASDigitalServiceActConfigPubRender) {
    /// Unknown
    SASDigitalServiceActConfigPubRenderUnknown = -1,
    
    /// Cannot render.
    SASDigitalServiceActConfigPubRenderCannotRender = 0,
    
    /// Could render.
    SASDigitalServiceActConfigPubRenderCouldRender = 1,
    
    /// Will render.
    SASDigitalServiceActConfigPubRenderWillRender = 2
};

NS_ASSUME_NONNULL_END
