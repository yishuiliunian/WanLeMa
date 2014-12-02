//
//  UIView+Rotation.h
//  Bending
//
//  Created by stonedong on 14/12/1.
//  Copyright (c) 2014年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Rotation)
- (void) startRotationAnimation;
- (void) stopRatationAnimation;
- (void) startMovitionAnimationToPointOffset:(CGFloat)x y:(CGFloat)y;
- (void) stopMovitionAnimation;
- (void) addSubImageViewWithName:(NSString*)name;
- (UIImageView*) imageViewByImageName:(NSString*)name;
@end
