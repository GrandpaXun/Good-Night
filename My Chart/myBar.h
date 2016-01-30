//
//  myBar.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "myBar.h"

@interface myBar : UIView

@property (nonatomic) float grade;

@property (nonatomic,strong) CAShapeLayer * chartLine;			//使用画线的类来画折线图

@property (nonatomic, strong) UIColor * barColor;

@end