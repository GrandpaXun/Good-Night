//
//  SleepConditionViewController.m
//  Good Night
//
//  Created by nju on 16/1/21.
//  Copyright © 2016年 nju. All rights reserved.
//

#import "SleepConditionViewController.h"
#import "RootViewTableViewController.h"
@interface SleepConditionViewController ()

@end

@implementation SleepConditionViewController


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.tmp = nil;							//释放tmp
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    double temp = [appDelegate.appDefault doubleForKey:@"this"];         //显示当前睡眠质量评价

    self.photo.hidden = YES;
    self.photoSecond.hidden = YES;
    self.photoThird.hidden = YES;
    self.photoFourth.hidden = YES;

    if(temp == 0)													//根据用户平均睡眠时间给出总结
        self.photo.hidden = NO;
    else if(temp < 6)
        self.photoSecond.hidden = NO;
    else if (temp < 8)
        self.photoThird.hidden = NO;
    else
        self.photoFourth.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
