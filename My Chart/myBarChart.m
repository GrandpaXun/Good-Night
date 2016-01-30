//
//  myBarChart.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myBarChart.h"
#import "myChartLabel.h"
#import "myBar.h"

@interface myBarChart (){
    UIScrollView *myScrollView;
}

@end

@implementation myBarChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {								// 初始化操作
        self.clipsToBounds = YES;
        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(myYLabelwidth, 0, frame.size.width - myYLabelwidth, frame.size.height)];
        [self addSubview:myScrollView];
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues{			//设置y的值
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels{			//被上一个函数调用设置y的值
    NSInteger max = 0;
    NSInteger min = 1000000000;
    
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max)							//所有数据中的最小值作为y的最小值，最大值组为y的最大值
                max = value;
            
            if (value < min) 
                min = value;
            
        }
    }
    
    if (max < 5)
        max = 5;

    if (self.showRange)							
        _yValueMin = (int)min;
    else
        _yValueMin = 0;

    _yValueMax = (int)max;
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    
    float level = (_yValueMax-_yValueMin) / 4.0;					//设置尺寸
    CGFloat chartCavanHeight = self.frame.size.height - myLabelHeight * 3;
    CGFloat levelHeight = chartCavanHeight / 4.0;
    
    for (int i = 0; i < 5; i++) {					//设置y轴的label
        myChartLabel *label = [[myChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight - i*levelHeight + 5, myYLabelwidth, myLabelHeight)];
        label.text = [NSString stringWithFormat:@"%.1f",level * i + _yValueMin];
        [self addSubview:label];
    }
    
}

-(void)setXLabels:(NSArray *)xLabels{			//设置x轴的label
    if( !_chartLabelsForX )
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    
    
    _xLabels = xLabels;
    NSInteger num;
    
    if (xLabels.count>=8)					//横坐标的个数在4~8个之间
        num = 8;
    else if (xLabels.count<=4)
        num = 4;
    else
        num = xLabels.count;
    
    _xLabelWidth = myScrollView.frame.size.width/num;
    
    for (int i = 0; i < xLabels.count; i++) {			//将label加到scrollview中
        myChartLabel * label = [[myChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), self.frame.size.height - myLabelHeight, _xLabelWidth, myLabelHeight)];
        label.text = xLabels[i];
        [myScrollView addSubview:label];
        
        [_chartLabelsForX addObject:label];
    }
    
    float max = (([xLabels count]-1) * _xLabelWidth + chartMargin) + _xLabelWidth;		//调整scrollview以适应横坐标
    if (myScrollView.frame.size.width < max - 10)
        myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
}

-(void)setColors:(NSArray *)colors{				//设置颜色
    _colors = colors;
}

- (void)setChooseRange:(CGRange)chooseRange {			
    _chooseRange = chooseRange;
}

-(void)strokeChart{							//将条形图加到scrollview里并动画显示条形
    
    CGFloat chartCavanHeight = self.frame.size.height - myLabelHeight * 3;
    
    for (int i = 0; i < _yValues.count; i++) {
        if (i == 2)
            return;
        
        NSArray *childAry = _yValues[i];
        for (int j = 0; j < childAry.count; j++) {
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            float grade = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            
            myBar *bar = [[myBar alloc] initWithFrame:CGRectMake((j + (_yValues.count == 1 ? 0.1 : 0.05)) * _xLabelWidth + i * _xLabelWidth * 0.47, myLabelHeight, _xLabelWidth * (_yValues.count == 1 ? 0.8 : 0.45), chartCavanHeight)];
            bar.barColor = [_colors objectAtIndex:i];
            bar.grade = grade;
            [myScrollView addSubview:bar];
            
        }
    }
}

- (NSArray *)chartLabelsForX{				//返回横坐标所有label
    return [_chartLabelsForX allObjects];
}

@end
