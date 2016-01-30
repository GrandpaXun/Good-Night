//
//  myChart.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myChart.h"

@interface myChart ()

@property (strong, nonatomic) myLineChart * lineChart;

@property (strong, nonatomic) myBarChart * barChart;

@property (assign, nonatomic) id<myChartDataSource> dataSource;

@end

@implementation myChart

-(id)initwithMyChartDataFrame:(CGRect)rect withSource:(id <myChartDataSource>)dataSource withStyle:(myChartStyle)style{
    self.dataSource = dataSource;
    self.chartStyle = style;
    return [self initWithFrame:rect];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)setUpChart{
    if (self.chartStyle == myChartLineStyle) {
        if(!_lineChart){
            _lineChart = [[myLineChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_lineChart];
        }
        
        //选择标记范围
        if ([self.dataSource respondsToSelector:@selector(myChartMarkRangeInLineChart:)])
            [_lineChart setMarkRange:[self.dataSource myChartMarkRangeInLineChart:self]];
        
        
        //选择显示范围
        if ([self.dataSource respondsToSelector:@selector(myChartChooseRangeInLineChart:)])
            [_lineChart setChooseRange:[self.dataSource myChartChooseRangeInLineChart:self]];
        
        
        //显示颜色
        if ([self.dataSource respondsToSelector:@selector(myChart_ColorArray:)])
            [_lineChart setColors:[self.dataSource myChart_ColorArray:self]];
        
        
        //显示横线
        if ([self.dataSource respondsToSelector:@selector(myChart:ShowHorizonLineAtIndex:)]) {
            NSMutableArray *showHorizonArray = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < 5; i++) {
                if ([self.dataSource myChart:self ShowHorizonLineAtIndex:i])
                    [showHorizonArray addObject:@"1"];
                
                else
                    [showHorizonArray addObject:@"0"];

            }
            [_lineChart setShowHorizonLine:showHorizonArray];
            
        }
        //判断显示最大最小值
        if ([self.dataSource respondsToSelector:@selector(myChart:ShowMaxMinAtIndex:)]) {
            NSMutableArray *showMaxMinArray = [[NSMutableArray alloc]init];
            NSArray *y_values = [self.dataSource myChart_yValueArray:self];
            
            if (y_values.count > 0){
                for (int i = 0; i < y_values.count; i++) {
                    if ([self.dataSource myChart:self ShowMaxMinAtIndex:i])
                        [showMaxMinArray addObject:@"1"];
    
                    else
                        [showMaxMinArray addObject:@"0"];
                }
                
                _lineChart.ShowMaxMinArray = showMaxMinArray;
            }
        }
        
        [_lineChart setYValues:[self.dataSource myChart_yValueArray:self]];
        [_lineChart setXLabels:[self.dataSource myChart_xLableArray:self]];
        
        [_lineChart strokeChart];
        
    }
    else if (self.chartStyle == myChartBarStyle) {
        if (!_barChart) {
            _barChart = [[myBarChart alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self addSubview:_barChart];
        }
        
        if ([self.dataSource respondsToSelector:@selector(myChartChooseRangeInLineChart:)]) {
            [_barChart setChooseRange:[self.dataSource myChartChooseRangeInLineChart:self]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(myChart_ColorArray:)]) {
            [_barChart setColors:[self.dataSource myChart_ColorArray:self]];
        }
        
        [_barChart setYValues:[self.dataSource myChart_yValueArray:self]];
        [_barChart setXLabels:[self.dataSource myChart_xLableArray:self]];
        
        [_barChart strokeChart];
    }
}

- (void)showInView:(UIView *)view{
    [self setUpChart];
    [view addSubview:self];
}

-(void)strokeChart{
    [self setUpChart];
    
}



@end