//
//  sleepDataForDay.m
//  Good Night
//
//  Created by nju on 15/12/19.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "sleepDataForDay.h"

@implementation sleepDataForDay

//归档睡眠记录
-(void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.dataForDay forKey:@"dataForDay"];
    [encoder encodeFloat:self.totalSleepHours forKey:@"totalSleepHours"];
    [encoder encodeInteger:self.currentDay forKey:@"currentDay"];
}

//解档睡眠记录
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self){
        self.dataForDay= [decoder decodeObjectForKey:@"dataForDay"];
        self.totalSleepHours = [decoder decodeFloatForKey:@"totalSleepHours"];
        self.currentDay = [decoder decodeIntForKey:@"currentDay"];
        
    }
    return self;
}
@end
