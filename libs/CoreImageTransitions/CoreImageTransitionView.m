//
//  TransitionView.m
//
//  Created by shuichi on 13/03/10.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import "CoreImageTransitionView.h"
#import "CoreImageTransitionHelper.h"


@interface CoreImageTransitionView ()
<GLKViewDelegate>
{
    CFTimeInterval startTime;
    CGRect imageRect;
}
@property (nonatomic, strong) CIImage *maskImage;
@property (nonatomic, strong) CIImage *shadingImage;
@property (nonatomic, strong) CIVector *extent;
@property (nonatomic, strong) CIContext *myContext;
@property (nonatomic, assign) CADisplayLink *displayLink;
@end


@implementation CoreImageTransitionView

- (instancetype)initWithFrame:(CGRect)frame
                    fromImage:(UIImage *)fromImage
                      toImage:(UIImage *)toImage
{
    self = [super initWithFrame:frame];
    if (self) {

        startTime = [NSDate timeIntervalSinceReferenceDate];
        self.duration = 1.0;

        // 遷移前後の画像とマスク画像を生成
        UIImage *uiMaskImage = [UIImage imageNamed:@"mask.jpg"];
        UIImage *uiShadingImage = [UIImage imageNamed:@"restrictedshine.tiff"];
        
        _inputImage       = [CIImage imageWithCGImage:fromImage.CGImage];
        _inputTargetImage = [CIImage imageWithCGImage:toImage.CGImage];
        self.maskImage = [CIImage imageWithCGImage:uiMaskImage.CGImage];
        self.shadingImage = [CIImage imageWithCGImage:uiShadingImage.CGImage];
        
        CGFloat width = fromImage.size.width * fromImage.scale;
        CGFloat height = fromImage.size.height * fromImage.scale;
        // 表示領域を示す矩形（CGRect型）
        imageRect = CGRectMake(0, 0, width, height);
        
        
        // 遷移アニメーションが起こる領域を示す矩形（CIVector型）
        self.extent = [CIVector vectorWithX:0 Y:0 Z:width W:height];
        
        // EAGLDelegateの設定
        self.delegate = self;
        
        // コンテキスト生成
        self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        self.myContext = [CIContext contextWithEAGLContext:self.context];        
    }
    return self;
}

- (void)dealloc {
    [self stop];
}


// =============================================================================
#pragma mark - Private

- (CIImage *)imageForTransitionAtTime:(float)time
{
    [self.transition setValue:self.inputImage forKey:kCIInputImageKey];
    [self.transition setValue:self.inputTargetImage forKey:kCIInputTargetImageKey];

    [self.transition setValue:@(time) forKey:kCIInputTimeKey];
        
    // フィルタ処理実行
    CIImage *transitionImage = [self.transition valueForKey:kCIOutputImageKey];
    
    return transitionImage;
}


// =============================================================================
#pragma mark - Public

- (void)start {
    
    startTime = CACurrentMediaTime();
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onTimer:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.displayLink = displayLink;

    [self onTimer:displayLink];
}

- (void)stop {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)changeTransition:(CoreImageTransitionType)type {
    
    CIImage *optionImage;
    
    switch (type) {
            
        case CoreImageTransitionTypeDisintegrateWithMask:
            optionImage = self.maskImage;
            break;

        case CoreImageTransitionTypePageCurl:
            optionImage = self.shadingImage;
            break;


        case CoreImageTransitionTypeRipple:
            optionImage = self.shadingImage;
            break;

        default:
            // no option image
            break;
            
    }
    
    if (optionImage) {
        _transition = [CoreImageTransitionHelper transitionWithType:type
                                                             extent:self.extent
                                                        optionImage:optionImage];
    }
    else {
        _transition = [CoreImageTransitionHelper transitionWithType:type
                                                             extent:self.extent];
    }
}

- (NSString *)currentFilterName {
    
    return self.transition.name;
}


// =============================================================================
#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {

    float dt = ([self.displayLink timestamp] - startTime) / self.duration;

    if (dt < 0) {
        dt = 0;
    }
    
    // finished
    if (dt > 1.0) {
        return;
    }
    
    CIImage *image = [self imageForTransitionAtTime:dt];
    
    // 描画領域を示す矩形
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGRect nativeBounds = [[UIScreen mainScreen] nativeBounds];
    CGRect destRect = CGRectMake(0, self.bounds.size.height * scale - imageRect.size.height,
                                 nativeBounds.size.width,
                                 nativeBounds.size.height);
    
    [self.myContext drawImage:image
                       inRect:destRect
                     fromRect:imageRect];
}


// =============================================================================
#pragma mark - Timer Handler

- (void)onTimer:(CADisplayLink *)link {

    [self setNeedsDisplay];
}

@end



@implementation UIView (Snapshot)
- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    
    // http://stackoverflow.com/questions/6402393/screenshot-from-a-uitableview
    if ([self isKindOfClass:[UITableView class]]) {
        CGContextTranslateCTM(graphicsContext, 0,
                              -[(UITableView *)self contentOffset].y);
    }
    
    CGContextFillRect(graphicsContext, self.bounds);
    
    // good explanation of differences between drawViewHierarchyInRect:afterScreenUpdates: and renderInContext:
    // https://github.com/radi/LiveFrost/issues/10#issuecomment-28959525
    [self.layer renderInContext:graphicsContext];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}
@end
