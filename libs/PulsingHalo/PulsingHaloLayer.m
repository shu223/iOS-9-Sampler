//
//  PulsingHaloLayer.m
//  https://github.com/shu223/PulsingHalo
//
//  Created by shuichi on 12/5/13.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//
//  Inspired by https://github.com/samvermette/SVPulsingAnnotationView


#import "PulsingHaloLayer.h"


@interface PulsingHaloLayer () <CAAnimationDelegate>
@property (nonatomic, strong) CALayer *effect;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;
@end


@implementation PulsingHaloLayer
@dynamic repeatCount;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.effect = [CALayer new];
        self.effect.contentsScale = [UIScreen mainScreen].scale;
        self.effect.opacity = 0;
        [self addSublayer:self.effect];
        
        [self _setupDefaults];
    }
    return self;
}


// =============================================================================
#pragma mark - Accessor

- (void)start {
    [self _setupAnimationGroup];
    [self.effect addAnimation:self.animationGroup forKey:@"pulse"];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.effect.frame = frame;
}

- (void)setBackgroundColor:(CGColorRef)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.effect.backgroundColor = backgroundColor;
}

- (void)setRadius:(CGFloat)radius {
    
    _radius = radius;
    
    CGFloat diameter = self.radius * 2;
    
    self.effect.bounds = CGRectMake(0, 0, diameter, diameter);
    self.effect.cornerRadius = self.radius;
}

- (void)setPulseInterval:(NSTimeInterval)pulseInterval {
    
    _pulseInterval = pulseInterval;
    
    if (_pulseInterval == INFINITY) {
        [self.effect removeAnimationForKey:@"pulse"];
    }
}

- (void)setHaloLayerNumber:(NSInteger)haloLayerNumber {
    
    _haloLayerNumber = haloLayerNumber;
    self.instanceCount = haloLayerNumber;
    self.instanceDelay = (self.animationDuration + self.pulseInterval) / haloLayerNumber;
}

- (void)setStartInterval:(NSTimeInterval)startInterval {
    
    _startInterval = startInterval;
    self.instanceDelay = startInterval;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration {

    _animationDuration = animationDuration;
    
    self.instanceDelay = (self.animationDuration + self.pulseInterval) / self.haloLayerNumber;
}

- (void)setRepeatCount:(float)repeatCount {
    [super setRepeatCount:repeatCount];
    self.animationGroup.repeatCount = repeatCount;
}


// =============================================================================
#pragma mark - Private

- (void)_setupDefaults {
    _fromValueForRadius = 0.0;
    _keyTimeForHalfOpacity = 0.2;
    _animationDuration = 3;
    _pulseInterval = 0;
    _useTimingFunction = YES;

    self.repeatCount = INFINITY;
    self.radius = 60;
    self.haloLayerNumber = 1;
    self.startInterval = 1;
    self.backgroundColor = [[UIColor colorWithRed:0.000 green:0.455 blue:0.756 alpha:0.45] CGColor];
}

- (void)_setupAnimationGroup {
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = self.animationDuration + self.pulseInterval;
    animationGroup.repeatCount = self.repeatCount;
    if (self.useTimingFunction) {
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        animationGroup.timingFunction = defaultCurve;
    }
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @(self.fromValueForRadius);
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = self.animationDuration;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = self.animationDuration;
    CGFloat fromValueForAlpha = CGColorGetAlpha(self.backgroundColor);
    opacityAnimation.values = @[@(fromValueForAlpha), @(fromValueForAlpha * 0.5), @0];
    opacityAnimation.keyTimes = @[@0, @(self.keyTimeForHalfOpacity), @1];
    
    NSArray *animations = @[scaleAnimation, opacityAnimation];
    
    animationGroup.animations = animations;
    
    self.animationGroup = animationGroup;
    self.animationGroup.delegate = self;
}


// =============================================================================
#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if ([self.effect.animationKeys count]) {
        [self.effect removeAllAnimations];
    }
    [self.effect removeFromSuperlayer];
    [self removeFromSuperlayer];
}

@end
