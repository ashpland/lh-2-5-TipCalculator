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
@property (assign, nonatomic) int tipPercentage;
@property (assign, nonatomic) float tipIncrement;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipPercentage = 15;
    self.totalAmountLabel.adjustsFontSizeToFitWidth = YES;
    self.totalAmountLabel.minimumScaleFactor = 0.5;
    self.tipAmountLabel.adjustsFontSizeToFitWidth = YES;
    self.tipAmountLabel.minimumScaleFactor = 0.5;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.billAmountTextField becomeFirstResponder];
}

- (IBAction)viewPanned:(id)sender {
    
    CGPoint translationInView = [sender translationInView:self.view];
    
    NSLog(@"Y: %f", translationInView.y);
    
    self.tipIncrement = self.tipIncrement + translationInView.y;

    float threshold = 30;
    
    if (fabsf(self.tipIncrement) > threshold) {
        
        self.tipPercentage = self.tipPercentage - self.tipIncrement / threshold;
        
        self.tipPercentage = self.tipPercentage > 1 ? self.tipPercentage : 1;
        self.tipPercentage = self.tipPercentage < 99 ? self.tipPercentage : 99;
        
        self.percentAmountTextField.text = [NSString stringWithFormat:@"%d%%", self.tipPercentage];
        
        [self updateTipAndTotal];
        
        self.tipIncrement = 0;
    }
    

    
    [sender setTranslation:CGPointZero inView:self.view];

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    bool stringToAddIsntANumber = [string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != 0;
    bool isDeletingLastChar = range.length == 1;
    
    bool editingPercent = [textField isEqual:self.percentAmountTextField];
    int tooLong = editingPercent ? 3 : 9;
    bool stringIsTooLong = textField.text.length >= tooLong;
    
    NSString *updatedString;
    if (isDeletingLastChar) {
        int lastCharLocation = editingPercent ? 2 : 1;
        updatedString = [textField.text substringToIndex:textField.text.length - lastCharLocation];
    }
    else if ((stringIsTooLong || stringToAddIsntANumber)) {
        return NO;
    } else {
        updatedString = [textField.text stringByAppendingString:string];
    }
    
    float cleanNumber = [self getCleanFloatFromString:updatedString];
    
    if ([textField isEqual:self.billAmountTextField]) {
        self.currentSubtotal = cleanNumber;
        textField.text = [NSString stringWithFormat:@"$%.2f", cleanNumber];
        
    } else if ([textField isEqual:self.percentAmountTextField]) {
        self.tipPercentage = (int)(cleanNumber * 100);
        textField.text = [NSString stringWithFormat:@"%d%%", self.tipPercentage];
    }
    
    if (cleanNumber == 0)
        textField.text = @"";
    
    [self updateTipAndTotal];
    
    return NO;
}




-(float)getCleanFloatFromString:(NSString *)currentString
{
    NSString *cleanString = [[[currentString stringByReplacingOccurrencesOfString:@"$" withString:@""]
                              stringByReplacingOccurrencesOfString:@"." withString:@""]
                             stringByReplacingOccurrencesOfString:@"%" withString:@""];
    
    return [cleanString floatValue] * 0.01;
}

-(void)updateTipAndTotal
{
    self.tipPercentage = self.tipPercentage > 0 ? self.tipPercentage : 15;
    self.currentSubtotal = self.currentSubtotal > 0 ? self.currentSubtotal : 5;
    
    float tipAmount = self.currentSubtotal * self.tipPercentage / 100;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", self.currentSubtotal + tipAmount];
}


@end
