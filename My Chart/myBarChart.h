//
//  myBarChart.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myColor.h"

#define chartMargin     10						//属性宏的定义
#define xLabelMargin    15
#define yLabelMargin    15
#define myLabelHeight   10
#define myYLabelwidth   30

@interface myBarChart : UIView					//条形图

-(void)strokeChart;

@property (strong, nonatomic) NSArray *xLabels;

@property (strong, nonatomic) NSArray *yLabels;

@property (strong, nonatomic) NSArray *yValues;

@property (nonatomic) CGFloat xLabelWidth;

@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

@property (nonatomic, assign) BOOL showRange;			//判断是否显示某个范围

@property (nonatomic, assign) CGRange chooseRange;		//存储选中的范围

@property (nonatomic, strong) NSArray *colors;

- (NSArray *)chartLabelsForX;

@end
