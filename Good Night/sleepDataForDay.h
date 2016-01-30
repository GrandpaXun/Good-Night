//
//  sleepDataForDay.h
//  Good Night
//
//  Created by nju on 15/12/19.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "sleepData.h"

@interface sleepDataForDay : NSObject <NSCoding>

@property NSMutableArray *dataForDay;

@property float totalSleepHours;

@property NSInteger currentDay;



@end

