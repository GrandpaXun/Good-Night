//
//  SecondViewController.m
//  Good Night
//
//  Created by nju on 15/11/30.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()



@property int textFieldSeleted;

@property UIPickerView *lastPick;			//用户上一个选中的pickerview
@property UIPickerView *nowPick;			//用户当前选中的pickerview

@end

@implementation SecondViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{		//用户的数据通过segue返回给tableview
    if(sender != self.saveButton){
        self.tmp = nil;
        return;
    }
    
    self.tmp.startHour = self.startHour.text;
    self.tmp.startMinute = self.startMinute.text;
    self.tmp.endHour = self.endHour.text;
    self.tmp.endtMinute = self.endMinute.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tmp = [[sleepData alloc] init];				//以下是一些初始化操作
    self.sleepDataPool = [[NSMutableArray alloc] init];
    
    
    self.hourPick.hidden = YES;
    self.hourPick.delegate = self;
    self.hourPick.dataSource = self;
    self.minutePick.hidden = YES;
    self.minutePick.delegate = self;
    self.minutePick.dataSource = self;
    
    self.startHour.delegate = self;
    self.startMinute.delegate = self;
    self.endHour.delegate = self;
    self.endMinute.delegate = self;
    
    hourArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",nil];
    minuteArray = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 

    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;														//pickerview只有一列
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{			//确定pickerview一列中的行数
    if(pickerView == self.hourPick)
        return hourArray.count;
    else return minuteArray.count;						
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{			
    return self.view.frame.size.width;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{		//每一行的view
    if(!view)
        view = [[UIView alloc] init];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    if(pickerView == self.hourPick)
        text.text = [hourArray objectAtIndex:row];
    else
        text.text = [minuteArray objectAtIndex:row];
    [view addSubview:text];
    return view;
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{		//每行的属性
    NSString *str = [[NSString alloc] init];
    if(pickerView == self.hourPick)
        str = [hourArray objectAtIndex:row];
    else str = [minuteArray objectAtIndex:row];
    NSMutableAttributedString *AttributeString=[[NSMutableAttributedString alloc] initWithString:str];
    [AttributeString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, [AttributeString length])];
    return AttributeString;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{				//每行显示的内容
    NSString *str = [[NSString alloc] init];
    if(pickerView == self.hourPick)
        str = [hourArray objectAtIndex:row];
    else str = [minuteArray objectAtIndex:row];
    return str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{					//当选中一行的时候，实时显示到textfield里
    
    switch (self.textFieldSeleted) {
        case 0:{if(row > hourArray.count)return; self.startHour.text = [hourArray objectAtIndex:row];break;}
        case 1:{if(row > minuteArray.count)return; self.startMinute.text = [minuteArray objectAtIndex:row];break;}
        case 2:{if(row > hourArray.count)return; self.endHour.text = [hourArray objectAtIndex:row];break;}
        case 3:{if(row > minuteArray.count)return; self.endMinute.text = [minuteArray objectAtIndex:row];break;}
    }
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{			//用户点击textfield时，弹出pickerview
    UIPickerView *nowPick;
    if (textField == self.startHour){
        self.textFieldSeleted = 0;
        nowPick = self.hourPick;
    }
    else if (textField == self.startMinute){
        self.textFieldSeleted = 1;
        nowPick = self.minutePick;
    }
    else if (textField == self.endHour){
        self.textFieldSeleted = 2;
        nowPick = self.hourPick;
    }
    else{
        self.textFieldSeleted = 3;
        nowPick = self.minutePick;
    }
    
    self.nowPick.hidden = YES;
    
    CGRect lastframe = nowPick.frame;
    nowPick.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*2/3);

    nowPick.hidden = NO;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    nowPick.frame = lastframe;
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    
    self.lastPick = self.nowPick;
    self.nowPick = nowPick;
    
    return NO;
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
