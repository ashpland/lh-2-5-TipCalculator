//
//  SplitViewController.h
//  TipCalculator
//
//  Created by Andrew on 2017-10-14.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bill.h"


@interface SplitViewController : UIViewController

@property (strong, nonatomic) Bill *theBill;

-(instancetype)initWIthBill:(Bill *)theBill;


@end
