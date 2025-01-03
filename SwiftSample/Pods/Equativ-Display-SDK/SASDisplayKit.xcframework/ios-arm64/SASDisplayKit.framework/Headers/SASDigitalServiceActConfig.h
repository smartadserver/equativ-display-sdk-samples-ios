//
//  SASDigitalServiceActConfig.h
//  SASDisplayKit
//
//  Created by Guillaume LAUBIER on 14/10/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SASDisplayKit/SASDigitalServiceActConfigTransparency.h>

NS_ASSUME_NONNULL_BEGIN

/// Indicates if DSA information should be made available. This will signal if the bid request belongs to an Online Platform/VLOP, such that a buyer should respond with DSA Transparency information based on the `pubrender` value.
/// Please see IAB documentation https://github.com/InteractiveAdvertisingBureau/openrtb/blob/main/extensions/community_extensions/dsa_transparency.md#object-dsa
typedef NS_ENUM(NSInteger, SASDigitalServiceActDSARequired) {
    /// Not required.
    SASDigitalServiceActDSARequiredNotRequired = 0,
    
    /// Supported, bid responses with or without DSA object will be accepted.
    SASDigitalServiceActDSARequiredSupported = 1,
    
    /// Required, bid responses without DSA object will not be accepted.
    SASDigitalServiceActDSARequiredRequired = 2,
    
    /// Required, bid repsonses without DSA object will not be accepted, Publisher is an Online Platform.
    SASDigitalServiceActDSARequiredRequiredPublisherOnlinePlatform = 3,
};

/// Indicates whether transparency data are to be sent. Independent of the `pubrender` parametern the publisher may need the transparency data for audit purposes.
/// Please see IAB documentation https://github.com/InteractiveAdvertisingBureau/openrtb/blob/main/extensions/community_extensions/dsa_transparency.md#object-dsa
typedef NS_ENUM(NSInteger, SASDigitalServiceActDataToPub) {
    /// Do not send transparency data.
    SASDigitalServiceActDataToPubDoNotSendTransparencyData = 0,
    
    /// Optional to send transparency data.
    SASDigitalServiceActDataToPubOptionalToSendTransparencyData = 1,
    
    /// Send transparency data.
    SASDigitalServiceActDataToPubSendTransparencyData = 2,
};

/**
 Model class centralizing useful Digital Service Act information.
 */
@interface SASDigitalServiceActConfig : NSObject

/// Indicates if DSA information should be made available
@property (readonly) SASDigitalServiceActDSARequired DSARequired;

/// Indicates whether transparency data are to be sent
@property (readonly) SASDigitalServiceActDataToPub dataToPub;

/// Array of SASDigitalServiceActConfigTransparency instances
@property (nullable, readonly) NSArray<SASDigitalServiceActConfigTransparency *> *transparency;

/**
 Initializes a new instance of SASDigitalServiceActConfig.
 
 @param DSARequired ID indicating if DSA information should be made available.
 @param dataToPub ID indicating whether transparency data are to be sent.
 @param transparency Array of SASDigitalServiceActConfigTransparency instances.
 
 @return An initialized instance of SASDigitalServiceActConfig.
 */
- (instancetype)initWithDSARequired:(SASDigitalServiceActDSARequired)DSARequired
                          dataToPub:(SASDigitalServiceActDataToPub)dataToPub
                       transparency:(nullable NSArray<SASDigitalServiceActConfigTransparency *> *)transparency;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
