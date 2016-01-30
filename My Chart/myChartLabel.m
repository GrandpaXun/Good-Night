//
//  myChartLabel.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myChartLabel.h"

@implementation myChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {						// 初始化label的一些属性
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        [self setMinimumScaleFactor:5.0f];
        [self setNumberOfLines:1];
        [self setFont:[UIFont boldSystemFontOfSize:9.0f]];
        [self setTextColor: myDeepGrey];
        self.backgroundColor = [UIColor clearColor];
        [self setTextAlignment:NSTextAlignmentCenter];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

@end
