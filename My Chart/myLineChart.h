//
//  myLineChart.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myColor.h"

#define chartMargin     10							//属性宏的定义
#define xLabelMargin    15
#define yLabelMargin    15
#define myLabelHeight    10
#define myYLabelwidth     30
#define myTagLabelwidth     80

@interface myLineChart : UIView						//折线图

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic, strong) NSArray * colors;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;

@property (nonatomic, assign) CGRange markRange;

@property (nonatomic, assign) CGRange chooseRange;

@property (nonatomic, assign) BOOL showRange;

@property (nonatomic, retain) NSMutableArray *ShowHorizonLine;
@property (nonatomic, retain) NSMutableArray *ShowMaxMinArray;

-(void)strokeChart;

- (NSArray *)chartLabelsForX;

@end
