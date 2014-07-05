//
//  DTFriendsPickerVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFriendsPickerVC.h"
#import "DTModelManager.h"

#define NIB_NAME @"DTFriendsPickerVC"

@interface DTFriendsPickerVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSArray *friendList;

@end

@implementation DTFriendsPickerVC

+ (DTFriendsPickerVC *)newController
{
    DTFriendsPickerVC *controller = [[DTFriendsPickerVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Pick a friend";
    return controller;
}

//- (void)registerToMainUserUpdateNotification
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainUserUpdateNotificationHandler) name:DTNotificationMainUserUpdate object:nil];
//}

#pragma mark - View life cycle 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFetchRequest];
    
//    [self reloadTableView];
}

//#pragma mark - DTNotificationMainUserUpdate
//
//- (void)mainUserUpdateNotificationHandler
//{
//    [self reloadTableView];
//}

#pragma mark - DTCoreDataTableViewController

- (void)setUpFetchRequest
{
    self.fetchedResultsController = [DTModelManager fetchResultControllerForMainUserFriends];
}

- (void)tableViewShouldRefresh
{
    [self stopRefreshingTableView];
}


#pragma mark - UITableViewDataSource

//- (void)reloadTableView
//{
//    self.friendList = [DTModelManager userFriends];
//    [self.tableView reloadData];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    DTPerson *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = friend.firstName;
    cell.detailTextLabel.text = friend.lastName;
    
    return cell;
}

@end
