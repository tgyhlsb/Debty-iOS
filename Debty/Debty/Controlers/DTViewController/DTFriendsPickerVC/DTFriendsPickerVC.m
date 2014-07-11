//
//  DTFriendsPickerVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFriendsPickerVC.h"
#import "DTModelManager.h"
#import "DTPerson.h"
#import "DTCreateAccountVC.h"
#import "DTInstallation.h"

#define NIB_NAME @"DTFriendsPickerVC"

@interface DTFriendsPickerVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation DTFriendsPickerVC

+ (DTFriendsPickerVC *)newController
{
    DTFriendsPickerVC *controller = [[DTFriendsPickerVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Pick a friend";
    controller.canPullToRefresh = YES;
    controller.clearsSelectionOnViewWillAppear = YES;
    return controller;
}

#pragma mark - View life cycle 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerToTextFieldNotification];
    [self setUpFetchRequest];
}

#pragma mark - Handlers

- (void)registerToTextFieldNotification
{
    [self.searchTextField addTarget:self action:@selector(searchTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)searchTextFieldValueDidChange
{
    [self setUpFetchRequest];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForMainUserFriendsWithSearchString:self.searchTextField.text];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    DTPerson *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = friend.firstName;
    cell.detailTextLabel.text = friend.lastName;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTPerson *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    DTPerson *me = [DTInstallation mainUser];
    DTAccount *newAccount = [DTAccount accountWithPersons:@[me, friend]];
    NSLog(@"%@", newAccount);
    
//    DTCreateAccountVC *destination = [DTCreateAccountVC newController];
//    [self.navigationController pushViewController:destination animated:YES];
}

@end
