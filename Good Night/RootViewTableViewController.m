//
//  RootViewTableViewController.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "RootViewTableViewController.h"

@interface RootViewTableViewController () <UITableViewDataSource, UITableViewDelegate>


@end

@implementation RootViewTableViewController

//处理从添加睡眠记录界面获得的睡眠信息
-(IBAction)unwindToTable:(UIStoryboardSegue *)Segue{
    SecondViewController *source = [Segue sourceViewController];
    if(source.tmp == NULL)
        return;
    sleepData *saveData = [[sleepData alloc]init];
    saveData = source.tmp;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    self.test++;
    NSInteger number = ([comps weekday]-2+7)%7;
    //NSInteger number = (self.test-2+7)%7;
        self.date = number+1;
  
    sleepDataForDay *element = [self.thisWeekData objectAtIndex:number];
    NSInteger tmp = [comps day];
    if(element.totalSleepHours==0||element.currentDay!=tmp){
        self.count ++;
       
    }
    if(self.date>self.count)
        self.count = self.date;
    NSLog(@"DATE:%li",(long)_date);
    NSLog(@"COUNT:%li",(long)_count);
    if(self.count==8){
        self.count = 0;
        for(int i = 0;i<7;i++){
          [self.lastWeekData replaceObjectAtIndex:i withObject:[self.thisWeekData objectAtIndex:i]];
        }
        for(int i = 0;i<7;i++){
            sleepDataForDay *temp =  [[sleepDataForDay alloc]init];
            [self.thisWeekData replaceObjectAtIndex:i withObject:temp];
        }
        element = [self.thisWeekData objectAtIndex:number];
    }

    //将睡眠记录添加到数据结构中
    if(element.dataForDay==nil){
        sleepDataForDay *newDay = [[sleepDataForDay alloc]init];
        newDay.dataForDay = [[NSMutableArray alloc]init];
        [newDay.dataForDay addObject:saveData];
        newDay.totalSleepHours = (((float)[saveData.endHour intValue]+24)*60+(float)[saveData.endtMinute intValue]-(float)[saveData.startHour intValue]*60-(float)[saveData.startMinute intValue])/60;
        if(newDay.totalSleepHours>24)
            newDay.totalSleepHours -= 24;
        newDay  .currentDay = [comps day];
        //NSLog(@"%f",newDay.totalSleepHours);
        [element.dataForDay addObject:saveData];
        [self.thisWeekData replaceObjectAtIndex:number withObject:newDay];
    }
    else {
        
        [element.dataForDay addObject:saveData];
        element.totalSleepHours = element.totalSleepHours+  (((float)[saveData.endHour intValue]+24)*60+(float)[saveData.endtMinute intValue]-(float)[saveData.startHour intValue]*60-(float)[saveData.startMinute intValue])/60;
        if(element.totalSleepHours>24)
            element.totalSleepHours -= 24;
        //NSLog(@"%f",element.totalSleepHours);
        //NSLog(@"hehehehehhehehhe");
    }
    
    //计算平均睡眠时间
    element.currentDay = [comps day];
    NSInteger allDay = 0;
    float averageTimeLast = 0;
    for(int i = 0;i<7;i++){
        sleepDataForDay *select = [self.lastWeekData objectAtIndex:i];
        averageTimeLast += select.totalSleepHours;
        if(select.totalSleepHours != 0)
            allDay++;
    }
    if(allDay == 0)
        averageTimeLast = 0;
    else
        averageTimeLast /= allDay;
    NSString *stringTime = [NSString stringWithFormat:@"%0.1f",averageTimeLast];
    self.averageTimeOfLastWeek.text = [stringTime stringByAppendingString:@"Hours"];
    float averageTimeThis = 0;
    allDay=0;
    for(int i = 0;i<7;i++){
        sleepDataForDay *select = [self.thisWeekData objectAtIndex:i];
        averageTimeThis += select.totalSleepHours;
        if(select.totalSleepHours != 0)
            allDay++;
    }
    if(allDay == 0)
        averageTimeThis = 0;
    else
        averageTimeThis /= allDay;
    stringTime = [NSString stringWithFormat:@"%0.1f",averageTimeThis];
    self.averageTimeOfThisWeek.text = [stringTime stringByAppendingString:@"Hours"];
    [self.tableView reloadData];
    self.timeOfLast = averageTimeLast;
    self.timeOfThis = averageTimeThis;
    [appDelegate.appDefault setDouble:averageTimeThis  forKey:@"this"];
    [appDelegate.appDefault setDouble:averageTimeLast  forKey:@"last"];
    
    //将睡眠记录进行归档
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *fileNameOfLast = @"Documents/sleepOfLast.data";
        NSString *fileNameOfThis = @"Documents/sleepOfThis.data";
        NSString *homePath = NSHomeDirectory();
        NSString *path1 = [homePath stringByAppendingPathComponent:fileNameOfLast];
        NSString *path2 = [homePath stringByAppendingPathComponent:fileNameOfThis];
        NSMutableArray *lastWeek = self.lastWeekData;
        bool flag1 = [NSKeyedArchiver archiveRootObject:lastWeek toFile:path1];
      
        NSMutableArray *thisWeek = self.thisWeekData;
        bool flag2 = [NSKeyedArchiver archiveRootObject:thisWeek toFile:path2];
        if(!flag1||!flag2)
            NSLog(@"fail to archive");
        else
            NSLog(@"sucess to archive");
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    //将睡眠记录解档
    NSString *fileNameOfLast = @"Documents/sleepOfLast.data";
    NSString *fileNameOfThis = @"Documents/sleepOfThis.data";
    NSString *homePath = NSHomeDirectory();
    NSString *path1 = [homePath stringByAppendingPathComponent:fileNameOfLast];
    NSString *path2 = [homePath stringByAppendingPathComponent:fileNameOfThis];
    self.lastWeekData = [NSKeyedUnarchiver unarchiveObjectWithFile:path1];
    self.thisWeekData = [NSKeyedUnarchiver unarchiveObjectWithFile:path2];
    
    //处理睡眠记录
    if(!self.lastWeekData){
        self.lastWeekData = [[NSMutableArray alloc]init];
        self.thisWeekData = [[NSMutableArray alloc]init];     
    }
    else{
        //获得平均睡眠时间
        NSInteger allDay = 0;
        float averageTimeLast = 0;
        for(int i = 0;i<7;i++){
        sleepDataForDay *select = [self.lastWeekData objectAtIndex:i];
        averageTimeLast += select.totalSleepHours;
        if(select.totalSleepHours != 0)
            allDay++;
        }
        if(allDay == 0)
            averageTimeLast = 0;
        else
        averageTimeLast /= allDay;
        NSString *stringTime = [NSString stringWithFormat:@"%0.1f",averageTimeLast];
        self.averageTimeOfLastWeek.text = [stringTime stringByAppendingString:@"Hours"];
        float averageTimeThis = 0;
        allDay=0;
        for(int i = 0;i<7;i++){
            sleepDataForDay *select = [self.thisWeekData objectAtIndex:i];
            averageTimeThis += select.totalSleepHours;
            if(select.totalSleepHours != 0)
                allDay++;
        }
        if(allDay == 0)
            averageTimeThis = 0;
        else
            averageTimeThis /= allDay;

        //保存当前平均睡眠时间
        stringTime = [NSString stringWithFormat:@"%0.1f",averageTimeThis];
        self.averageTimeOfThisWeek.text = [stringTime stringByAppendingString:@"Hours"];
        [appDelegate.appDefault setDouble:averageTimeThis  forKey:@"this"];
        [appDelegate.appDefault setDouble:averageTimeLast  forKey:@"last"];
        [self.tableView reloadData];
    }

    
    for(int i = 0;i<7;i++){
        sleepDataForDay *add = [[sleepDataForDay alloc]init];
        [self.lastWeekData addObject:add];
    }
    for(int i = 0;i<7;i++){
        sleepDataForDay *add = [[sleepDataForDay alloc]init];
        [self.thisWeekData addObject:add];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    
    static NSString *cellIdentifier = @"TableViewCell";
    
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    if(cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] firstObject];
      
    }
 
    
    cell.thisWeek = [[NSMutableArray alloc]init];
    cell.lastWeek = [[NSMutableArray alloc]init];
    for(int i=0;i<7;i++){
        [cell.thisWeek addObject:@"0"];
    }
    for(int i=0;i<7;i++){
        [cell.lastWeek addObject:@"5"];
    }
    for(int i = 0;i<7;i++){
        sleepDataForDay *element = [self.thisWeekData objectAtIndex:i];
        double number = element.totalSleepHours;
        NSString *ch ;
        ch = [NSString stringWithFormat:@"%lf\n",number];
        [cell.thisWeek replaceObjectAtIndex:i withObject:ch];
    }
    for(int i = 0;i<7;i++){
        sleepDataForDay *element = [self.lastWeekData objectAtIndex:i];
        double number = element.totalSleepHours;
        NSString *ch ;
        ch = [NSString stringWithFormat:@"%lf\n",number];
        [cell.lastWeek replaceObjectAtIndex:i withObject:ch];
    }
    [cell configUI:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 30);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    label.text = section ? @"Your sleep this week" : @"Your sleep last week";
    label.textColor = [UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
    //label.textColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
