//
//  TipViewController.h
//  TipCalculator
//
//  Created by Andrew on 2017-10-13.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bill.h"

@interface TipViewController : UIViewController

@property (nonatomic, strong) Bill *theBill;
@property (strong, nonatomic) UIViewController *nextView;
@property (strong, nonatomic) UIPageViewController *pageView;


-(instancetype)initWIthBill:(Bill *)theBill;


@end

