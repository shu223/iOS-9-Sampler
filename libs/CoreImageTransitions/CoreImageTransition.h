//
//  CoreImageTransition.h
//
//  Created by Shuichi Tsutsumi on 10/5/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreImageTransitionTypes.h"


#define kCoreImageTransitionTypeNameDissolve     @"Dissolve"
#define kCoreImageTransitionTypeNameCopyMachine  @"CopyMachine"
#define kCoreImageTransitionTypeNameFlash        @"Flash"
#define kCoreImageTransitionTypeNameMod          @"Mod"
#define kCoreImageTransitionTypeNameSwipe        @"Swipe"
#define kCoreImageTransitionTypeNameDisintegrateWithMask  @"DisintegrateWithMask"
#define kCoreImageTransitionTypeNamePageCurl     @"PageCurl"
#define kCoreImageTransitionTypeNamePageCurlWithShadow  @"PageCurlWithShadow"
#define kCoreImageTransitionTypeNameRipple       @"Ripple"


@interface CoreImageTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CoreImageTransitionType type;
@property (nonatomic, assign) BOOL presenting;

- (void)setTransitionTypeWithName:(NSString *)name;

@end
