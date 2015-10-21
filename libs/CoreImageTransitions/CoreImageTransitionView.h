//
//  TransitionView.h
//
//  Created by shuichi on 13/03/10.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "CoreImageTransitionTypes.h"


@interface CoreImageTransitionView : GLKView

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong, readonly) CIFilter *transition;
@property (nonatomic, strong, readonly) CIImage *inputImage;
@property (nonatomic, strong, readonly) CIImage *inputTargetImage;

- (instancetype)initWithFrame:(CGRect)frame
                    fromImage:(UIImage *)fromImage
                      toImage:(UIImage *)toImage;

- (void)start;
- (void)stop;

- (void)changeTransition:(CoreImageTransitionType)type;
- (NSString *)currentFilterName;

@end


@interface UIView (Snapshot)
- (UIImage *)snapshot;
@end
