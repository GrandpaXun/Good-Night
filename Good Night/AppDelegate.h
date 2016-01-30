//
//  AppDelegate.h
//  Good Night
//
//  Created by nju on 15/11/30.
//  Copyright (c) 2015年 nju. All rights reserved.
//

#import <UIKit/UIKit.h>
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (assign, nonatomic)NSUserDefaults *appDefault;

@property (strong, nonatomic) UIWindow *window;

@end
