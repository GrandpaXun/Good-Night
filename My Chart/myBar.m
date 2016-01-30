//
//  myBar.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myBar.h"
#import "myColor.h"

@implementation myBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {							// 初始化属性
        _chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapSquare;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = self.frame.size.width;
        _chartLine.strokeEnd   = 0.0;
        self.clipsToBounds = YES;

        [self.layer addSublayer:_chartLine];
        self.layer.cornerRadius = 2.0;
    }
    
    return self;
}

-(void)setGrade:(float)grade{
    if (grade == 0)
        return;
    
    _grade = grade;
    UIBezierPath *progressline = [UIBezierPath bezierPath];		//画线
    
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height+30)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - grade) * self.frame.size.height+15)];
    [progressline setLineWidth:1.0];
    [progressline setLineCapStyle:kCGLineCapSquare];
    _chartLine.path = progressline.CGPath;
    
    if (_barColor)			//设置线条颜色
        _chartLine.strokeColor = [_barColor CGColor];
    
    else
        _chartLine.strokeColor = [myGreen CGColor];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];		//以动画方式绘出线条
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartLine.strokeEnd = 2.0;
}

- (void)drawRect:(CGRect)rect{						//画出图
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
}


@end

