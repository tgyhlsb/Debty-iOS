//
//  DTExpenseTableViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseTableViewCell.h"

#define NIB_NAME @"DTExpenseTableViewCell"
#define HEIGHT 44

@interface DTExpenseTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DTExpenseTableViewCell

#pragma mark - View

- (void)updateView
{
    self.nameLabel.text = self.expense.name;
}

#pragma mark - Setters

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    [self updateView];
}

#pragma mark - Subclass methods

+ (NSString *)reusableIdentifier
{
    return NIB_NAME;
}

+ (void)registerToTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[DTExpenseTableViewCell reusableIdentifier]];
}

+ (CGFloat)height
{
    return HEIGHT;
}

@end
