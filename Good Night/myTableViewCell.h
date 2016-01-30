//
//  myTableViewCell.h
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

@interface myTableViewCell : UITableViewCell

@property NSMutableArray *thisWeek;                          //这个星期的睡眠区间数据
															 //上个星期的睡眠区间数据
@property NSMutableArray *lastWeek;							

- (void)configUI:(NSIndexPath *)indexPath;

@end
