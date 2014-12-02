//
//  UIView+Rotation.m
//  Bending
//
//  Created by stonedong on 14/12/1.
//  Copyright (c) 2014年 stonedong. All rights reserved.
//

#import "UIView+Rotation.h"
#import <DZProgramDefines.h>

#import <DZImageCache.h>

int DZImageViewTagWithName(NSString* name)
{
    int tag;
    
    static NSMutableDictionary* tagCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tagCache = [NSMutableDictionary new];
    });
    
    NSNumber* cachedTag = tagCache[name];
    
    if (!cachedTag) {
        for (; ; ) {
            tag = random()%7888+1000;
            if (![tagCache objectForKey:@(tag)]) {
                [tagCache setObject:@(tag) forKey:name];
                [tagCache setObject:@(tag) forKey:@(tag)];
                break;
            }
        }
        
    } else {
        tag = [cachedTag integerValue];
    }
    return tag;
}

INIT_DZ_EXTERN_STRING(kDZRatationAnimation, kDZRatationAnimation);
@implementation UIView (Rotation)

- (void) startRotationAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSNotFound;
    
    [self.layer addAnimation:rotationAnimation forKey:kDZRatationAnimation];
}

- (void) stopRatationAnimation
{
    CAAnimation* ratationAnimation = [self.layer animationForKey:kDZRatationAnimation];
    if (ratationAnimation) {
        [self.layer removeAnimationForKey:kDZRatationAnimation];
    }
}
- (void) addSubImageViewWithName:(NSString*)name {
    UIImageView* imageView = [[UIImageView alloc] initWithImage:DZCachedImageByName(name)];
    [self addSubview:imageView];
    imageView.tag = DZImageViewTagWithName(name);
}
- (UIImageView*) imageViewByImageName:(NSString*)name
{
    int tag = DZImageViewTagWithName(name);
    return (UIImageView*) [self viewWithTag:tag];
}

INIT_DZ_EXTERN_STRING(kDZMovitonAnimation, kDZMovitonAnimation);
- (void) startMovitionAnimationToPointOffset:(CGFloat)x y:(CGFloat)y
{
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGPoint old = self.layer.position;
    CGPoint other = old;
    other.x += x;
    other.y += y;
    
    animation.fromValue = [NSValue valueWithCGPoint:old];
    animation.toValue = [NSValue valueWithCGPoint:other];
    
    animation.duration = 1;
    animation.repeatCount = 111;
    [self.layer addAnimation:animation forKey:kDZMovitonAnimation];
    
}

- (void) stopMovitionAnimation
{
    [self.layer removeAnimationForKey:kDZMovitonAnimation];
}

@end
