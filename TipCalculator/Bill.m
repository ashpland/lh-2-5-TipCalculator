//
//  Bill.m
//  TipCalculator
//
//  Created by Andrew on 2017-10-14.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "Bill.h"

@implementation Bill

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tipPercentage = 15;
        _currentSubtotal = 500;
        _peopleSharing = 5;

    }
    return self;
}



-(void)changeTipPercentage:(int)increment
{
    self.tipPercentage = self.tipPercentage + increment;
    
    self.tipPercentage = self.tipPercentage > 0 ? self.tipPercentage : 0;
    self.tipPercentage = self.tipPercentage < 99 ? self.tipPercentage : 99;
    
}


-(int)tipAmount
{
    return self.currentSubtotal * self.tipPercentage / 100;
}

-(int)totalAmount
{
    return self.currentSubtotal + self.tipAmount;
}

-(int)totalShare
{
    return self.totalAmount / self.peopleSharing;
}

-(NSString *)subtotalAmountString
{
    return [self getCurrencyStringFrom:self.currentSubtotal];
}

-(NSString *)tipPercentageString
{
    return [self getPercentStringFrom:self.tipPercentage];
}

-(NSString *)tipAmountString
{
    return [self getCurrencyStringFrom:self.tipAmount];
}
-(NSString *)totalAmountString
{
    return [self getCurrencyStringFrom:self.totalAmount];
}

-(NSString *)totalShareString
{
    return [self getCurrencyStringFrom:self.totalShare];
}


-(NSString *)getCurrencyStringFrom:(int)centsInt
{
    
    NSString *padZeros;
    if (10 < centsInt && centsInt < 100 )
        padZeros = @"0";
    else if (centsInt < 10)
        padZeros = @"00";
    else
        padZeros = @"";

    
    NSMutableString *newCurrencyString = [NSMutableString stringWithFormat:@"$%@%d", padZeros, centsInt];
    [newCurrencyString insertString:@"." atIndex:newCurrencyString.length - 2];
    return newCurrencyString;
}

-(NSString *)getPercentStringFrom:(int)percentInt
{
    return [NSString stringWithFormat:@"%d%%", percentInt];
}



@end
