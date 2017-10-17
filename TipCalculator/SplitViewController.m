//
//  SplitViewController.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-14.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleSharing;
@property (weak, nonatomic) IBOutlet UILabel *sharePerPersonLabel;
@property (weak, nonatomic) IBOutlet UISlider *peopleSlider;

- (IBAction)sliderChanges:(UISlider *)sender;
- (IBAction)leftEdgePan:(UIScreenEdgePanGestureRecognizer *)sender;




@end

@implementation SplitViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.totalAmountLabel.text = [self.theBill totalAmountString];
    self.sharePerPersonLabel.text = [self.theBill totalShareString];
    
    
}


- (IBAction)sliderChanges:(UISlider *)sender {
    int sliderValue = sender.value + 0.5;
    NSLog(@"Int: %d, Float:%f", sliderValue, sender.value);

    self.theBill.peopleSharing = sliderValue;
    
    self.peopleSlider.value = sliderValue;
    self.numberOfPeopleSharing.text = [NSString stringWithFormat:@"%d", sliderValue];
    self.sharePerPersonLabel.text = [self.theBill totalShareString];
}

- (IBAction)leftEdgePan:(UIScreenEdgePanGestureRecognizer *)sender {
    [self.pageView setViewControllers:@[self.nextView] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];

}
@end
