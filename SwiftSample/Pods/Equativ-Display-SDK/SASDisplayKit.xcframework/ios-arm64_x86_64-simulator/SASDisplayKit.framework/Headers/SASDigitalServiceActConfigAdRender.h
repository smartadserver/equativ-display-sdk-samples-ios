//
//  SASDigitalServiceActConfigAdRender.h
//  SASDisplayKit
//
//  Created by Guillaume LAUBIER on 02/04/2025.
//  Copyright © 2025 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SASDigitalServiceActConfigAdRender) {
    /// Unknown.
    SASDigitalServiceActConfigAdRenderUnknown = -1,
    
    /// Advertiser will not render.
    SASDigitalServiceActConfigAdRenderAdvertiserWillNotRender = 0,
    
    /// Advertiser will render.
    SASDigitalServiceActConfigAdRenderAdvertiserWillRender = 1
};

NS_ASSUME_NONNULL_END
