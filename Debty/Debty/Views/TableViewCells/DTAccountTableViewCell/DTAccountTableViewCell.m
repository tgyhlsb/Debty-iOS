//
//  DTExpenseTableViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAccountTableViewCell.h"
#import "DTPerson+Helpers.h"
#import "DTOperationManager.h"
#import "DTGroupPictureView.h"
#import "DTInstallation.h"

#define NIB_NAME @"DTAccountTableViewCell"
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
    self.accountNameLabel.text = self.account.safeName;
    self.balanceLabel.text = [DTOperationManager currencyStringWithDecimalNumber:self.account.cachedBalance
                                                                withLocaleCode:self.account.localeCode];
    
    [self.pictureView reset];
    for (DTPerson *person in self.account.persons) {
        if (![person isEqual:[DTInstallation me]]) {
            [self.pictureView addUserID:person.facebookID withName:person.firstName];
        }
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
