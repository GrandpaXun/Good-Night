//
//  myChart.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myChart.h"
#import "myColor.h"
#import "myLineChart.h"
#import "myBarChart.h"

//类型
typedef enum {
    myChartLineStyle,
    myChartBarStyle
} myChartStyle;


@class myChart;

@protocol myChartDataSource <NSObject>

@required

//横坐标标题数组
- (NSArray *)myChart_xLableArray:(myChart *)chart;

//数值多重数组
- (NSArray *)myChart_yValueArray:(myChart *)chart;

@optional

//颜色数组
- (NSArray *)myChart_ColorArray:(myChart *)chart;

//显示数值范围
- (CGRange)myChartChooseRangeInLineChart:(myChart *)chart;

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)myChartMarkRangeInLineChart:(myChart *)chart;

//判断显示横线条
- (BOOL)myChart:(myChart *)chart ShowHorizonLineAtIndex:(NSInteger)index;

//判断显示最大最小值
- (BOOL)myChart:(myChart *)chart ShowMaxMinAtIndex:(NSInteger)index;

@end


@interface myChart : UIView

//是否自动显示范围
@property (nonatomic, assign) BOOL showRange;

@property (assign) myChartStyle chartStyle;

-(id)initwithMyChartDataFrame:(CGRect)rect withSource:(id <myChartDataSource>)dataSource withStyle:(myChartStyle)style;

- (void)showInView:(UIView *)view;

-(void)strokeChart;

@end