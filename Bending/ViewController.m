//
//  ViewController.m
//  Bending
//
//  Created by stonedong on 14/12/1.
//  Copyright (c) 2014年 stonedong. All rights reserved.
//

#import "ViewController.h"
#import <DZProgramDefines.h>
#import <UIColor+HexString.h>
#import <DZImageCache.h>
#import <DZProgramDefines.h>
#import <DZGeometryTools.h>
#import "UIView+Rotation.h"

CGRect CGRectWithCenterAndSize(CGPoint center, CGSize size){
    CGRect rect = CGRectZero;
    rect.origin.x = center.x - size.width/2;
    rect.origin.y = center.y - size.height/2;
    
    rect.size = size;
    return rect;
}

CGPoint CGPointOffSet(CGPoint p ,CGFloat x, CGFloat y) {
    p.x += x;
    p.y += y;
    return p;
}

@interface ViewController ()

@end



@implementation ViewController




INIT_DZ_EXTERN_STRING(kDZBigGearName, gear_2);
INIT_DZ_EXTERN_STRING(kDZLittleGearName, gear_1);
INIT_DZ_EXTERN_STRING(kDZPotBaseImageName, pot_base);
INIT_DZ_EXTERN_STRING(kDZLeidaContentName, leida_ping);
INIT_DZ_EXTERN_STRING(kDZLeidaArrowName, leida_arrow);
INIT_DZ_EXTERN_STRING(kDZLeidaPingMaskName, leidaping_mask);
#define SELF_IMAGEVIEW_WTIH_NAME(name) [self.view imageViewByImageName:name]


INIT_DZ_EXTERN_STRING(kDZLDCoverLeftUp, ld_left_up );
INIT_DZ_EXTERN_STRING(kDZLDCoverRightUp, ld_right_up);
INIT_DZ_EXTERN_STRING(kDZLDCoverDown, ld_down);


#define  LD_righUpIMG  [SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName) imageViewByImageName:kDZLDCoverRightUp]
#define  LD_leftUpIMG [SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName) imageViewByImageName:kDZLDCoverLeftUp]
#define  LD_downIMG [SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName) imageViewByImageName:kDZLDCoverDown]
#define  LD_arrowIMG [SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName) imageViewByImageName:kDZLeidaArrowName]

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"282e3a"];
    
    NSArray* imageNames = @[kDZBigGearName,
                            kDZLittleGearName,
                            kDZPotBaseImageName,
                            kDZLeidaContentName];
                            
    for (NSString* name in imageNames) {
        [self.view addSubImageViewWithName:name];
    }
    
    UIImageView* leidaContentImageView = SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName);
    [leidaContentImageView addSubImageViewWithName:kDZLeidaArrowName];
    [leidaContentImageView addSubImageViewWithName:kDZLDCoverDown];
    [leidaContentImageView addSubImageViewWithName:kDZLDCoverLeftUp];
    [leidaContentImageView addSubImageViewWithName:kDZLDCoverRightUp];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) startGearRotation
{
    [SELF_IMAGEVIEW_WTIH_NAME(kDZBigGearName) startRotationAnimation];
    [SELF_IMAGEVIEW_WTIH_NAME(kDZLittleGearName) startRotationAnimation];
}

- (void) stopGearRotation
{
    [SELF_IMAGEVIEW_WTIH_NAME(kDZBigGearName) stopRatationAnimation];
    [SELF_IMAGEVIEW_WTIH_NAME(kDZLittleGearName) stopRatationAnimation];
}

- (void) startCoverMovition
{
    [LD_leftUpIMG startMovitionAnimationToPointOffset:-LD_leftUpIMG.image.size.width y:-LD_leftUpIMG.image.size.height];
    [LD_righUpIMG startMovitionAnimationToPointOffset:LD_righUpIMG.image.size.width y:-LD_righUpIMG.image.size.height];
    [LD_downIMG startMovitionAnimationToPointOffset:0 y:LD_downIMG.image.size.height];
}

- (void) stopCoverMoviton
{
    [LD_leftUpIMG stopMovitionAnimation];
    [LD_righUpIMG stopMovitionAnimation];
    [LD_downIMG stopMovitionAnimation];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startGearRotation];
    [self startCoverMovition];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).maskView = [[UIImageView alloc] initWithImage:DZCachedImageByName(kDZLeidaContentName)];
    
    
    CGPoint leidaCenter = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    
   
    CGFloat scale = 0.9;
    CGSize potBaseSize = CGSizeScale(DZCachedImageByName(kDZPotBaseImageName).size, scale);
    
    SELF_IMAGEVIEW_WTIH_NAME(kDZPotBaseImageName).frame = CGRectWithCenterAndSize(leidaCenter, potBaseSize);
    
    SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).frame = CGRectWithCenterAndSize(CGPointOffSet(leidaCenter, -2, -12),
                                                                                  CGSizeScale( SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).image.size, scale));

    LD_arrowIMG.frame = CGRectMake(CGRectGetWidth(SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).frame) - LD_arrowIMG.image.size.width/2
                                                                   ,0
                                                                   ,LD_arrowIMG.image.size.width,
                                                                   LD_arrowIMG.image.size.height);
    
    LD_righUpIMG.frame = CGRectMake(CGRectGetWidth(SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).frame)/2, 0 , LD_righUpIMG.image.size.width, LD_righUpIMG.image.size.height);
    LD_leftUpIMG.frame = CGRectMake(0, 0, LD_leftUpIMG.image.size.width, LD_leftUpIMG.image.size.height);
    
    LD_downIMG.frame = CGRectMake((CGRectGetWidth(SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).frame) - LD_downIMG.image.size.width)/2, CGRectGetHeight(SELF_IMAGEVIEW_WTIH_NAME(kDZLeidaContentName).frame)/2, LD_downIMG.image.size.width, LD_downIMG.image.size.height);
    
    CGPoint bigGearCenter = CGPointOffSet(leidaCenter, - SELF_IMAGEVIEW_WTIH_NAME(kDZPotBaseImageName).frame.size.width*247/665, -SELF_IMAGEVIEW_WTIH_NAME(kDZPotBaseImageName).frame.size.height*156/715);
    
   

    SELF_IMAGEVIEW_WTIH_NAME(kDZBigGearName).frame =  CGRectWithCenterAndSize(bigGearCenter, SELF_IMAGEVIEW_WTIH_NAME(kDZBigGearName).image.size);
    SELF_IMAGEVIEW_WTIH_NAME(kDZLittleGearName).frame = CGRectWithCenterAndSize(CGPointOffSet(bigGearCenter, -5, 50), SELF_IMAGEVIEW_WTIH_NAME(kDZLittleGearName).image.size);
    

}

@end


