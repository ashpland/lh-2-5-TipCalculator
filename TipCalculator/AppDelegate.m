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
#import "SplitViewController.h"
#import "MyPageViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) Bill *theBill;
@property (nonatomic, strong) TipViewController *tipViewController;
@property (nonatomic, strong) SplitViewController *splitViewController;
@property (nonatomic, strong) MyPageViewController *pageViewController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.theBill = [Bill new];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.tipViewController = [storyboard instantiateViewControllerWithIdentifier:@"TipStoryboard"];
    self.tipViewController.theBill = self.theBill;
    
    self.splitViewController = [storyboard instantiateViewControllerWithIdentifier:@"SplitStoryboard"];
    self.splitViewController.theBill = self.theBill;
    
   
    
    
    self.pageViewController = [[MyPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    self.tipViewController.nextView = self.splitViewController;
    self.tipViewController.pageView = self.pageViewController;
    self.splitViewController.nextView = self.tipViewController;
    self.splitViewController.pageView = self.pageViewController;

    
    
    
    
    
    [self.pageViewController setViewControllers:@[self.tipViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    self.window.rootViewController = self.pageViewController;

    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
