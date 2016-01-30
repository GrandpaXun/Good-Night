                   //
//  SecondViewController.h
//  Good Night
//
//  Created by nju on 15/11/30.
//  Copyright © 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sleepData.h"

@interface SecondViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>{
    NSArray *hourArray;					//这个星期的睡眠区间数据
    NSArray *minuteArray;				//上个星期的睡眠区间数据
}

@property sleepData *tmp;				//tmp记录用户当前输入的区间

@property (weak, nonatomic) IBOutlet UIPickerView *hourPick;

@property (weak, nonatomic) IBOutlet UIPickerView *minutePick;

@property NSMutableArray *sleepDataPool;

@property (weak, nonatomic) IBOutlet UITextField *startHour;

@property (strong, nonatomic) IBOutlet UITextField *startMinute;

@property (strong, nonatomic) IBOutlet UITextField *endHour;

@property (strong, nonatomic) IBOutlet UITextField *endMinute;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) IBOutlet UIImageView *backGroundImage;

@end
