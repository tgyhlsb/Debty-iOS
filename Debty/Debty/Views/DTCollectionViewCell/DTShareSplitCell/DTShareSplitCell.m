//
//  DTShareSplitCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareSplitCell.h"
#import "DTShare+Helpers.h"
#import "DTShareCell.h"

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
    
    [DTShareCell registerToTableView:self.tableView];
}

+ (CGFloat)heightForNumberOfPersons:(NSInteger)numberOfPersons
{
    return numberOfPersons * HEIGHT;
}

- (void)setShares:(NSArray *)shares
{
    _shares = shares;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shares count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [DTShareCell reusableIdentifier];
    DTShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    DTShare *share = [self.shares objectAtIndex:indexPath.row];
    cell.share = share;
    cell.type = self.type;
    
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
