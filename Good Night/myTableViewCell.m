//
//  myTableViewCell.m
//  Good Night
//
//  Created by nju on 15/12/18.
//  Copyright © 2015年 nju. All rights reserved.
//

#import "myTableViewCell.h"
#import "myChart.h"

@interface myTableViewCell () <myChartDataSource> {
    NSIndexPath *path;
    myChart *chartView;
}
@end

@implementation myTableViewCell

- (void)configUI:(NSIndexPath *)indexPath{
    if (chartView) {
        [chartView removeFromSuperview];      //如果之前有一个图，撤销之前的图
        chartView = nil;
    }
    path = indexPath;
    chartView = [[myChart alloc] initwithMyChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 150) withSource:self withStyle:indexPath.section == 1 ? myChartBarStyle : myChartLineStyle];
    [chartView showInView:self.contentView];             //根据cell所在section重新生成新的cell
}

- (NSArray *)getXTitles:(int)num {                //生成横坐标
    NSMutableArray *xTitles = [NSMutableArray array];
    NSString * str1 = @"Sunday";
    [xTitles addObject:str1];
    NSString * str2 = @"Monday";
    [xTitles addObject:str2];
    NSString * str3 = @"Tuesday";
    [xTitles addObject:str3];
    NSString * str4 = @"Wednesday";
    [xTitles addObject:str4];
    NSString * str5 = @"Thurday";
    [xTitles addObject:str5];
    NSString * str6 = @"Friday";
    [xTitles addObject:str6];
    NSString * str7 = @"Saturday";
    [xTitles addObject:str7];
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)myChart_xLableArray:(myChart *)chart {       //返回横坐标有几个
    return [self getXTitles:7];
}

//数值多重数组
- (NSArray *)myChart_yValueArray:(myChart *)chart{               //获取纵坐标  

    if (path.section == 0) {
        return @[self.lastWeek];
    }
    else{
        return @[self.thisWeek];
    }
    
}

#pragma mark - @optional

//返回颜色数组，目前暂定有这四种颜色
- (NSArray *)myChart_ColorArray:(myChart *)chart{
    return @[myBlue, myRed, myGreen, myBrown];
}

//显示数值范围
- (CGRange)myChartChooseRangeInLineChart:(myChart *)chart {
    /*if (path.section == 0 && (path.row == 0 | path.row == 1)) {
        return CGRangeMake(24, 0);
    }
    if (path.section == 1 && path.row == 0) {
        return CGRangeMake(60, 10);
    }
    if (path.row == 2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;*/
    return CGRangeMake(15, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)myChartMarkRangeInLineChart:(myChart *)chart {
    /*if (path.row == 2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;*/
    return CGRangeMake(8, 12);
}

//判断是否显示横线条
- (BOOL)myChart:(myChart *)chart ShowHorizonLineAtIndex:(NSInteger)index {
    return YES;
}

//判断是否显示最大最小值
- (BOOL)myChart:(myChart *)chart ShowMaxMinAtIndex:(NSInteger)index {
    return path.row == 2;
}
@end
