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

@property (nonatomic) BOOL displaySelectedFriendTableView;

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

- (void)updateDoneButtonTitle
{
    if (self.displaySelectedFriendTableView) {
        NSInteger nbFriend = [[self selectedFriends] count];
        if (nbFriend > 1) {
            self.navigationItem.rightBarButtonItem.title = @"Next";
        } else {
            self.navigationItem.rightBarButtonItem.title = @"Done";
        }
    }
}

#pragma mark - View life cycle 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerToTextFieldNotification];
    [self showSelectedFriendList];
}

#pragma mark - Helpers

- (NSArray *)selectedFriends
{
    NSFetchedResultsController *selectedFriendsController = [DTModelManager fetchResultControllerForMainUserFriendsWithSearchString:nil selected:@(YES)];
    NSError *error = nil;
    [selectedFriendsController performFetch:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    return [selectedFriendsController fetchedObjects];
}

#pragma mark - Handlers

- (void)registerToTextFieldNotification
{
    [self.searchTextField addTarget:self action:@selector(searchTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)searchTextFieldValueDidChange
{
    if ([self.searchTextField.text length]) {
        [self hideSelectedFriendList];
    } else {
        [self showSelectedFriendList];
    }
}

#pragma mark - Selection process

- (void)addSelectedFriend:(DTPerson *)friend
{
    friend.isSelected = @(YES);
    self.searchTextField.text = @"";
    [self showSelectedFriendList];
}

- (void)removeSelectedFriend:(DTPerson *)friend
{
    friend.isSelected = @(NO);
}

- (void)showSelectedFriendList
{
    self.displaySelectedFriendTableView = YES;
    [self setUpFetchRequest];
}

- (void)hideSelectedFriendList
{
    self.displaySelectedFriendTableView = NO;
    [self setUpFetchRequest];
}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    if (self.displaySelectedFriendTableView) {
        self.fetchedResultsController = [DTModelManager fetchResultControllerForPersonsWithSearchString:nil selected:@(YES)];
    } else {
        self.fetchedResultsController = [DTModelManager fetchResultControllerForMainUserFriendsWithSearchString:self.searchTextField.text selected:@(NO)];
    }
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
    
    if (self.displaySelectedFriendTableView) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = friend.firstName;
    cell.detailTextLabel.text = friend.lastName;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTPerson *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (self.displaySelectedFriendTableView) {
        [self removeSelectedFriend:friend];
    } else {
        [self addSelectedFriend:friend];
    }
    
    [self updateDoneButtonTitle];
}

@end
