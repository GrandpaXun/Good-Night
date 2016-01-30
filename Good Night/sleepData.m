//
//  sleepData.m
//  Good Night
//
//  Created by nju on 15/12/6.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "sleepData.h"

@implementation sleepData

//归档睡眠记录
-(void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.startHour forKey:@"startHour"];
    [encoder encodeObject:self.startMinute forKey:@"startMinute"];
    [encoder encodeObject:self.endHour forKey:@"endHour"];
    [encoder encodeObject:self.endtMinute forKey:@"endtMinute"];


}

//解档睡眠记录
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self){
        self.startHour = [decoder decodeObjectForKey:@"startHour"];
        self.startMinute = [decoder decodeObjectForKey:@"startMinute"];
        self.endHour = [decoder decodeObjectForKey:@"endHour"];
        self.endtMinute = [decoder decodeObjectForKey:@"endtMinute"];
    }
    return self;
}

@end

