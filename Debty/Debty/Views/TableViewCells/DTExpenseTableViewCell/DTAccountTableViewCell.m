//
//  DTExpenseTableViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountTableViewCell.h"
#import "DTPerson+Serializer.h"
#import "DTGroupPictureView.h"

#define NIB_NAME @"DTExpenseTableViewCell"
#define HEIGHT 50.0

@interface DTAccountTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet DTGroupPictureView *pictureView;

@end

@implementation DTAccountTableViewCell

#pragma mark - View

- (void)updateView
{
    self.accountNameLabel.text = self.account.name;
    self.balanceLabel.text = [NSString stringWithFormat:@"%@", [self.account balanceForPerson:nil]];
    
    [self.pictureView reset];
    for (DTPerson *person in self.account.persons) {
        [self.pictureView addUserID:person.facebookID withName:person.firstName];
    }
    [self.pictureView updateLayout];
}

#pragma mark - Setters

- (void)setAccount:(DTAccount *)account
{
    _account = account;
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
    [tableView registerNib:nib forCellReuseIdentifier:[DTAccountTableViewCell reusableIdentifier]];
}

+ (CGFloat)height
{
    return HEIGHT;
}

@end
