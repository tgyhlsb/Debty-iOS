//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateExpenseVC.h"

#define NIB_NAME @"DTCreateExpenseVC"

@interface DTCreateExpenseVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;

@end

@implementation DTCreateExpenseVC

+ (instancetype)newController
{
    DTCreateExpenseVC *controller = [[DTCreateExpenseVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - Expense Attributes

- (NSString *)expenseName
{
    return self.nameLabel.text;
}

- (NSDecimalNumber *)expenseAmount
{
    return [NSDecimalNumber decimalNumberWithString:self.amountLabel.text];
}

@end
