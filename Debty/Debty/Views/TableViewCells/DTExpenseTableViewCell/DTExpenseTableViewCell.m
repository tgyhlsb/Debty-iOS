//
//  DTExpenseTableViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseTableViewCell.h"
#import "DTGroupPictureView.h"

#define NIB_NAME @"DTExpenseTableViewCell"
#define HEIGHT 50.0

@interface DTExpenseTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet DTGroupPictureView *pictureView;

@end

@implementation DTExpenseTableViewCell

#pragma mark - View

- (void)updateView
{
    self.userNameLabel.text = self.expense.userName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@", self.expense.price];
    
    [self.pictureView reset];
    [self.pictureView addUserID:self.expense.facebookID withName:self.expense.userName];
    [self.pictureView addUserID:self.expense.facebookID withName:self.expense.userName];
    [self.pictureView updateLayout];
}

#pragma mark - Setters

- (void)setExpense:(DTTempExpense *)expense
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
