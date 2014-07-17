//
//  DTWhoPayedPickerVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTWhoPayedPickerVC.h"
#import "DTModelManager.h"

#define NIB_NAME @"DTWhoPayedPickerVC"

@interface DTWhoPayedPickerVC ()

@end

@implementation DTWhoPayedPickerVC

+ (instancetype)newController
{
    DTWhoPayedPickerVC *controller = [[DTWhoPayedPickerVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFetchRequest];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForPersonInAccount:self.expense.account];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    DTPerson *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = person.firstName;
    cell.detailTextLabel.text = person.lastName;
    
    if ([person isEqual:self.whoPayed]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.whoPayed = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(whoPayedPickerDidSelectPerson:)]) {
        [self.delegate whoPayedPickerDidSelectPerson:self.whoPayed];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
