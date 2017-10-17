//
//  TipViewController.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-13.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *percentAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (assign, nonatomic) float tipIncrement;
- (IBAction)rightEdgePan:(UIScreenEdgePanGestureRecognizer *)sender;


@end

@implementation TipViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalAmountLabel.adjustsFontSizeToFitWidth = YES;
    self.totalAmountLabel.minimumScaleFactor = 0.5;
    self.tipAmountLabel.adjustsFontSizeToFitWidth = YES;
    self.tipAmountLabel.minimumScaleFactor = 0.5;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.billAmountTextField becomeFirstResponder];
     });
    // FIXME: Figure out why this doesn't work when swiping back
}



- (IBAction)viewPanned:(id)sender {
    
    CGPoint translationInView = [sender translationInView:self.view];
    
    self.tipIncrement = self.tipIncrement + translationInView.y;

    float threshold = 30;
    
    if (fabsf(self.tipIncrement) > threshold) {
        
        int tipChange = -1 * self.tipIncrement / threshold;
        
        [self.theBill changeTipPercentage:tipChange];
        
        self.percentAmountTextField.text = [self.theBill tipPercentageString];
        
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
    
    int cleanNumber = [self getCleanIntFromString:updatedString];
    
    if ([textField isEqual:self.billAmountTextField]) {
        self.theBill.currentSubtotal = cleanNumber;
        textField.text = [self.theBill subtotalAmountString];
        
    } else if ([textField isEqual:self.percentAmountTextField]) {
        self.theBill.tipPercentage = cleanNumber;
        textField.text = [self.theBill tipPercentageString];
    }
    
    if (cleanNumber == 0)
        textField.text = @"";
    
    [self updateTipAndTotal];
    
    return NO;
}




-(int)getCleanIntFromString:(NSString *)currentString
{
    NSString *cleanString = [[[currentString stringByReplacingOccurrencesOfString:@"$" withString:@""]
                              stringByReplacingOccurrencesOfString:@"." withString:@""]
                             stringByReplacingOccurrencesOfString:@"%" withString:@""];
    
    return [cleanString intValue];
}

-(void)updateTipAndTotal
{
    [self resetDefaultsIfFieldsAreEmpty];
    
    
    self.tipAmountLabel.text = [self.theBill tipAmountString];
    self.totalAmountLabel.text = [self.theBill totalAmountString];
}

-(void)resetDefaultsIfFieldsAreEmpty
{
    
    if ([self.tipAmountLabel.text isEqualToString:@""]){
        self.theBill.tipPercentage = 15;
    }
    if ([self.billAmountTextField.text isEqualToString:@""]){
        self.theBill.currentSubtotal = 500;
    }
}


- (IBAction)rightEdgePan:(UIScreenEdgePanGestureRecognizer *)sender {
    
    [self.pageView setViewControllers:@[self.nextView] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
@end
