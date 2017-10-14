//
//  Bill.h
//  TipCalculator
//
//  Created by Andrew on 2017-10-14.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject

@property (assign, nonatomic) int currentSubtotal;
@property (assign, nonatomic) int tipPercentage;
@property (assign, nonatomic, readonly) int tipAmount;
@property (assign, nonatomic, readonly) int totalAmount;
@property (strong, nonatomic, readonly) NSString *subtotalAmountString;
@property (strong, nonatomic, readonly) NSString *tipPercentageString;
@property (strong, nonatomic, readonly) NSString *tipAmountString;
@property (strong, nonatomic, readonly) NSString *totalAmountString;

-(void)changeTipPercentage:(int)increment;

@end
