//
//  SleepConditionViewController.h
//  Good Night
//
//  Created by nju on 16/1/21.
//  Copyright © 2016年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sleepData.h"
#import "AppDelegate.h"

@interface SleepConditionViewController : UIViewController

@property sleepData *tmp;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *photoSecond;
@property (weak, nonatomic) IBOutlet UIImageView *photoThird;
@property (weak, nonatomic) IBOutlet UIImageView *photoFourth;

@end
