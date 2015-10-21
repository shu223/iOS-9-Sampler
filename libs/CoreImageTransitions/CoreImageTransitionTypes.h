//
//  CoreImageTransitionTypes.h
//
//  Created by Shuichi Tsutsumi on 10/6/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CoreImageTransitionType) {
    CoreImageTransitionTypeCopyMachine,
    CoreImageTransitionTypeDisintegrateWithMask,
    CoreImageTransitionTypeDissolve,
    CoreImageTransitionTypeFlash,
    CoreImageTransitionTypeMod,
    CoreImageTransitionTypeSwipe,
    CoreImageTransitionTypePageCurl,
    CoreImageTransitionTypePageCurlWithShadow,
    CoreImageTransitionTypeRipple,

    CoreImageTransitionTypeGaussianBlur,
    CoreImageTransitionTypeDiscBlur,
    CoreImageTransitionTypeBoxBlur,
    CoreImageTransitionTypeMotionBlur,

    // --- not supported ----
    CoreImageTransitionTypeBarSwipe,
};
