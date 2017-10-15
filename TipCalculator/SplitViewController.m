//
//  SplitViewController.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-14.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "SplitViewController.h"
#import "Bill.h"

@interface SplitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleSharing;
@property (weak, nonatomic) IBOutlet UILabel *sharePerPersonLabel;
@property (weak, nonatomic) IBOutlet UISlider *peopleSlider;
@property (strong, nonatomic) Bill *theBill;

- (IBAction)sliderChanges:(UISlider *)sender;

@end

@implementation SplitViewController

-(instancetype)initWIthBill:(Bill *)theBill
{
    self = [super init];
    if (self) {
        _theBill = theBill;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)sliderChanges:(UISlider *)sender {
}
@end
