//
//  CITransitionHelper.h
//
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreImageTransitionTypes.h"


@class CIVector;
@class CIFilter;
@class CIImage;

@interface CoreImageTransitionHelper : NSObject

+ (CIFilter *)transitionWithType:(CoreImageTransitionType)type
                          extent:(CIVector *)extent;

+ (CIFilter *)transitionWithType:(CoreImageTransitionType)type
                          extent:(CIVector *)extent
                     optionImage:(CIImage *)optionImage;

@end
