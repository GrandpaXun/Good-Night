//
//  myLineChart.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myLineChart.h"
#import "myColor.h"
#import "myChartLabel.h"


@implementation myLineChart {
    NSHashTable *_chartLabelsForX;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels{
    NSInteger max = 0;
    NSInteger min = 1000000000;
    
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max)
                max = value;
            
            if (value < min)
                min = value;
        }
    }
    
    if (max < 5)
        max = 5;
    
    if (self.showRange)
        _yValueMin = min;
    else
        _yValueMin = 0;
    
    _yValueMax = (int)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    
    float level = (_yValueMax-_yValueMin) / 4.0;
    CGFloat chartCavanHeight = self.frame.size.height - myLabelHeight * 3;
    CGFloat levelHeight = chartCavanHeight / 4.0;
    
    for (int i = 0; i < 5; i++) {
        myChartLabel * label = [[myChartLabel alloc] initWithFrame:CGRectMake(0.0, chartCavanHeight - i * levelHeight + 5, myYLabelwidth, myLabelHeight)];
        label.text = [NSString stringWithFormat:@"%d",(int)(level * i + _yValueMin)];
        [self addSubview:label];
    }
    
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(myYLabelwidth, (1 - (_markRange.max - _yValueMin) / (_yValueMax-_yValueMin)) * chartCavanHeight + myLabelHeight, self.frame.size.width - myYLabelwidth, (_markRange.max-_markRange.min) / (_yValueMax-_yValueMin) * chartCavanHeight)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [self addSubview:view];
    }
    
    //画横线
    for (int i = 0; i < 5 ; i++) {
        if ([_ShowHorizonLine[i] integerValue] > 0) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(myYLabelwidth, myLabelHeight + i * levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, myLabelHeight + i * levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
    }
}

-(void)setXLabels:(NSArray *)xLabels{
    if( !_chartLabelsForX )
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    
    
    _xLabels = xLabels;
    CGFloat num = 0;
    
    if (xLabels.count >= 20)
        num = 20.0;
    else if (xLabels.count <= 1)
        num = 1.0;
    else
        num = xLabels.count;
    
    _xLabelWidth = (self.frame.size.width - myYLabelwidth) / num;
    
    for (int i = 0; i < xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        myChartLabel * label = [[myChartLabel alloc] initWithFrame:CGRectMake(i * _xLabelWidth + myYLabelwidth, self.frame.size.height - myLabelHeight, _xLabelWidth, myLabelHeight)];
        label.text = labelText;
        [self addSubview:label];
        
        [_chartLabelsForX addObject:label];
    }
    
    //画竖线
    for (int i = 0; i < xLabels.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(myYLabelwidth + i * _xLabelWidth, myLabelHeight)];
        [path addLineToPoint:CGPointMake(myYLabelwidth + i* _xLabelWidth, self.frame.size.height - 2 * myLabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 1;
        [self.layer addSublayer:shapeLayer];
    }
}

-(void)setColors:(NSArray *)colors{
    _colors = colors;
}

- (void)setMarkRange:(CGRange)markRange{
    _markRange = markRange;
}

- (void)setChooseRange:(CGRange)chooseRange{
    _chooseRange = chooseRange;
}

- (void)setShowHorizonLine:(NSMutableArray *)ShowHorizonLine{
    _ShowHorizonLine = ShowHorizonLine;
}


-(void)strokeChart{
    for (int i = 0; i < _yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count == 0)
            return;
        
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i = 0;
        NSInteger min_i = 0;
        
        for (int j = 0; j < childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max <= num){
                max = num;
                max_i = j;
            }
            if (min >= num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (myYLabelwidth + _xLabelWidth / 2.0);
        CGFloat chartCavanHeight = self.frame.size.height - myLabelHeight * 3;
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax - _yValueMin);
        
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.ShowMaxMinArray) {
            if ([self.ShowMaxMinArray[i] intValue]>0)
                isShowMaxAndMinPoint = (max_i == 0 || min_i == 0)? NO : YES;
            else
                isShowMaxAndMinPoint = YES;
            
        }
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight + myLabelHeight) index:i isShow:isShowMaxAndMinPoint value:firstValue];
        
        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight + myLabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        
        for (NSString * valueString in childAry) {
            
            float grade = ([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight + myLabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.ShowMaxMinArray) {
                    if ([self.ShowMaxMinArray[i] intValue] > 0)
                        isShowMaxAndMinPoint = (max_i == index || min_i == index) ? NO : YES;
                    else
                        isShowMaxAndMinPoint = YES;
                }
                
                [progressline moveToPoint:point];
                [self addPoint:point index:i isShow:isShowMaxAndMinPoint value:[valueString floatValue]];
                
                //[progressline stroke];
            }
            index++;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor])
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        else
            _chartLine.strokeColor = [myGreen CGColor];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 8, 8)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [[_colors objectAtIndex:index] CGColor] ? [[_colors objectAtIndex:index] CGColor] : myGreen.CGColor;
    
    if (isHollow)
        view.backgroundColor = [UIColor whiteColor];
    else {
        view.backgroundColor = [_colors objectAtIndex:index] ? [_colors objectAtIndex:index]:myGreen;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x - myTagLabelwidth / 2.0, point.y - myLabelHeight * 2, myTagLabelwidth, myLabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
}

- (NSArray *)chartLabelsForX{
    return [_chartLabelsForX allObjects];
}

@end
