//
//  AppDelegate.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-13.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "AppDelegate.h"
#import "Bill.h"
#import "TipViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) Bill *theBill;
@property (nonatomic, strong) TipViewController *tipViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.theBill = [Bill new];
    
    self.tipViewController = [[TipViewController alloc] initWIthBill:self.theBill];
    
    self.window.rootViewController = self.tipViewController;

    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
