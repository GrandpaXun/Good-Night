//
//  myColor.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  System Versioning Preprocessor Macros
 */

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define myGrey         [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0f]
#define myLightBlue    [UIColor colorWithRed:94.0/255.0 green:147.0/255.0 blue:196.0/255.0 alpha:1.0f]
#define myGreen        [UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define myTitleColor   [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:113.0/255.0 alpha:1.0f]
#define myButtonGrey   [UIColor colorWithRed:141.0/255.0 green:141.0/255.0 blue:141.0/255.0 alpha:1.0f]
#define myFreshGreen   [UIColor colorWithRed:77.0/255.0 green:196.0/255.0 blue:122.0/255.0 alpha:1.0f]
#define myRed          [UIColor colorWithRed:245.0/255.0 green:94.0/255.0 blue:78.0/255.0 alpha:1.0f]
#define myMauve        [UIColor colorWithRed:88.0/255.0 green:75.0/255.0 blue:103.0/255.0 alpha:1.0f]
#define myBrown        [UIColor colorWithRed:119.0/255.0 green:107.0/255.0 blue:95.0/255.0 alpha:1.0f]
#define myBlue         [UIColor colorWithRed:82.0/255.0 green:116.0/255.0 blue:188.0/255.0 alpha:1.0f]
#define myDarkBlue     [UIColor colorWithRed:121.0/255.0 green:134.0/255.0 blue:142.0/255.0 alpha:1.0f]
#define myYellow       [UIColor colorWithRed:242.0/255.0 green:197.0/255.0 blue:117.0/255.0 alpha:1.0f]
#define myWhite        [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f]
#define myDeepGrey     [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1.0f]
#define myPinkGrey     [UIColor colorWithRed:200.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0f]
#define myHealYellow   [UIColor colorWithRed:245.0/255.0 green:242.0/255.0 blue:238.0/255.0 alpha:1.0f]
#define myLightGrey    [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0f]
#define myCleanGrey    [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0f]
#define myLightYellow  [UIColor colorWithRed:241.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0f]
#define myDarkYellow   [UIColor colorWithRed:152.0/255.0 green:150.0/255.0 blue:159.0/255.0 alpha:1.0f]
#define myPinkDark     [UIColor colorWithRed:170.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0f]
#define myCloudWhite   [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0f]
#define myBlack        [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0f]
#define myStarYellow   [UIColor colorWithRed:252.0/255.0 green:223.0/255.0 blue:101.0/255.0 alpha:1.0f]
#define myTwitterColor [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:243.0/255.0 alpha:1.0]
#define myWeiboColor   [UIColor colorWithRed:250.0/255.0 green:0.0/255.0 blue:33.0/255.0 alpha:1.0]
#define myiOSGreenColor [UIColor colorWithRed:98.0/255.0 green:247.0/255.0 blue:77.0/255.0 alpha:1.0]
#define myRandomColor   [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]

//范围

struct Range {
    CGFloat max;
    CGFloat min;
};

typedef struct Range CGRange;

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange

CGRangeMake(CGFloat max, CGFloat min){
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0, 0};

@interface myColor : NSObject

- (UIImage *)imageFromColor:(UIColor *)color;

@end