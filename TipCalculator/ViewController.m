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
@property (assign, nonatomic) float currentSubtotal;
@property (assign, nonatomic) float tipPercentage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipPercentage = 0.15;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.billAmountTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // TODO: implement delete
    
    bool newStringIsntANumber = [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != 0;
    
    if (newStringIsntANumber) {
        return NO;
    }
    
//    NSString *oldValue;
//
//    if (textField.text.length == 0) {
//        oldValue = @"$0.00";
//    } else {
//        oldValue = textField.text;
//    }
    
    //NSString *oldValue = (textField.text.length == 0) ? @"$0.00" : textField.text;
    
    self.currentSubtotal = [self getFloatFromString:textField.text andAdd:string];
    
    textField.text = [NSString stringWithFormat:@"$%.2f", self.currentSubtotal];
    
    [self updateTipAndTotal];
    
    return NO;
}

-(float)getFloatFromString:(NSString *)currentString andAdd:(NSString *)nextCharacter
{
    NSString *cleanString = [[[currentString stringByReplacingOccurrencesOfString:@"$" withString:@""]
                                              stringByReplacingOccurrencesOfString:@"." withString:@""]
                                                 stringByAppendingString:nextCharacter];
    
    return [cleanString floatValue] * 0.01;
}

-(void)updateTipAndTotal
{
    float tipAmount = self.currentSubtotal * self.tipPercentage;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", self.currentSubtotal + tipAmount];
}


@end
