//
//  myColor.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myColor.h"

@implementation myColor

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(UIImage *)imageFromColor:(UIColor*)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
