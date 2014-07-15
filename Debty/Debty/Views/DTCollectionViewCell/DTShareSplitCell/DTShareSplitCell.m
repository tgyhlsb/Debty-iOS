//
//  DTShareSplitCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareSplitCell.h"
#import "DTPerson+Helpers.h"

#define NIB_NAME @"DTShareSplitCell"

#define HEIGHT 44.0

@interface DTShareSplitCell() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DTShareSplitCell

- (void)awakeFromNib
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

+ (CGFloat)heightForNumberOfPersons:(NSInteger)numberOfPersons
{
    return numberOfPersons * HEIGHT;
}

- (void)setPersons:(NSArray *)persons
{
    _persons = persons;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    DTPerson *person = [self.persons objectAtIndex:indexPath.row];
    cell.textLabel.text = person.firstName;
    
    return cell;
}

#pragma mark - Subclass methods

+ (NSString *)reusableIdentifier
{
    return NIB_NAME;
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView
{
    UINib *nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:[DTShareSplitCell reusableIdentifier]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:IDENTIFIER_EQUALLY];
    [collectionView registerNib:nib forCellWithReuseIdentifier:IDENTIFIER_EXACTLY];
    [collectionView registerNib:nib forCellWithReuseIdentifier:IDENTIFIER_PERCENT];
    [collectionView registerNib:nib forCellWithReuseIdentifier:IDENTIFIER_SHARE];
}


@end
