//
//  ViewController.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-13.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *percentAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.billAmountTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@", string);
    NSLog(@"%@", textField.text);
    
    //textField.text = @"$";
    
    int newSubtotal = [@"9.25" floatValue];
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", newSubtotal * 0.15];

    return YES;
}



@end
