//
//  RootViewTableViewController.h
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myTableViewCell.h"
#import "sleepDataForDay.h"
#import "sleepData.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
@interface RootViewTableViewController : UITableViewController

@property NSMutableArray *lastWeekData;
@property NSMutableArray *thisWeekData;
@property NSInteger count;
@property NSInteger date;
@property NSInteger test;
@property double timeOfLast;
@property double timeOfThis;

@property (weak, nonatomic) IBOutlet UILabel *averageTimeOfLastWeek;
@property (weak, nonatomic) IBOutlet UILabel *averageTimeOfThisWeek;



-(IBAction)unwindToTable:(UIStoryboardSegue *)Segue;

@end

