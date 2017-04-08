//
//  PulsingHaloLayer.h
//  https://github.com/shu223/PulsingHalo
//
//  Created by shuichi on 12/5/13.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//
//  Inspired by https://github.com/samvermette/SVPulsingAnnotationView


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface PulsingHaloLayer : CAReplicatorLayer

/**
 *	The default value of this property is @c 60pt.
 */
@property (nonatomic, assign) CGFloat radius;

/**
 *	The default value of this property is @c 0.0.
 */
@property (nonatomic, assign) CGFloat fromValueForRadius;

/**
 *	The default value of this property is @c 0.45.
 */
@property (nonatomic, assign) CGFloat fromValueForAlpha __attribute__ ((unavailable("Now the alpha channel of the backgroundColor is used.")));

/**
 *	The value of this property should be ranging from @c 0 to @c 1 (exclusive).
 *
 *	The default value of this property is @c 0.2.
 */
@property (nonatomic, assign) CGFloat keyTimeForHalfOpacity;

/**
 *	The animation duration in seconds.
 *
 *	The default value of this property is @c 3.
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 *	The animation interval in seconds.
 *
 *	The default value of this property is @c 0.
 */
@property (nonatomic, assign) NSTimeInterval pulseInterval;

/**
 *	The default value of this property is @c YES.
 */
@property (nonatomic, assign) BOOL useTimingFunction;

/**
 *	The default value of this property is @c 1.
 */
@property (nonatomic, assign) NSInteger haloLayerNumber;

/**
 *	The animation delay in seconds.
 *
 *	The default value of this property is @c 1.
 */
@property (nonatomic, assign) NSTimeInterval startInterval;

/**
 *  When this value is true, the halo will be automatically resumed after entering foreground.
 *
 *	The default value of this property is YES.
 */
@property (nonatomic, assign) BOOL shouldResume;

- (void)start;

@end
