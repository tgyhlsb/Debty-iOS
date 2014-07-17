//
//  DTSharesEditorVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTSharesEditorVC.h"
#import "DTShareSplitCell.h"
#import "DTAccount+Helpers.h"
#import "DTExpense+Helpers.h"
#import "DTShare+Helpers.h"

#define NIB_NAME @"DTSharesEditorVC"


#define INDEX_SPLIT_EQUALLY 0
#define INDEX_SPLIT_EXACTLY 1
#define INDEX_SPLIT_PERCENT 2
#define INDEX_SPLIT_SHARE   3

@interface DTSharesEditorVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) DTShareSplitCell *equallySplitCell;
@property (strong, nonatomic) DTShareSplitCell *exactSplitCell;
@property (strong, nonatomic) DTShareSplitCell *perCentSplitCell;
@property (strong, nonatomic) DTShareSplitCell *shareSplitCell;

@end

@implementation DTSharesEditorVC


+ (instancetype)newController
{
    DTSharesEditorVC *controller = [[DTSharesEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}


#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionViewHeightConstraint.constant = [DTShareSplitCell heightForNumberOfPersons:[self.expense.account.persons count]];
    
    [DTShareSplitCell registerToCollectionView:self.collectionView];
}

#pragma mark - Handlers

- (IBAction)segmentedControlHandler
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:self.segmentedControl.selectedSegmentIndex];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (DTShareSplitCell *)equallySplitCell
{
    if (!_equallySplitCell) {
        NSString *identifier = IDENTIFIER_EQUALLY;
        _equallySplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_EQUALLY inSection:0]];
        _equallySplitCell.shares = [self.expense.shares sortedArrayUsingDescriptors:nil];
        _equallySplitCell.type = DTShareSplitCellTypeEqually;
        _equallySplitCell.backgroundColor = [UIColor redColor];
    }
    return _equallySplitCell;
}

- (DTShareSplitCell *)exactSplitCell
{
    if (!_exactSplitCell) {
        NSString *identifier = IDENTIFIER_EXACTLY;
        _exactSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_EXACTLY inSection:0]];
        _exactSplitCell.shares = [self.expense.shares sortedArrayUsingDescriptors:nil];
        _exactSplitCell.type = DTShareSplitCellTypeExactly;
        _exactSplitCell.backgroundColor = [UIColor greenColor];
    }
    return _exactSplitCell;
}

- (DTShareSplitCell *)perCentSplitCell
{
    if (!_perCentSplitCell) {
        NSString *identifier = IDENTIFIER_PERCENT;
        _perCentSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_PERCENT inSection:0]];
         _perCentSplitCell.shares = [self.expense.shares sortedArrayUsingDescriptors:nil];
        _perCentSplitCell.type = DTShareSplitCellTypePercent;
        _perCentSplitCell.backgroundColor = [UIColor blueColor];
    }
    return _perCentSplitCell;
}

- (DTShareSplitCell *)shareSplitCell
{
    if (!_shareSplitCell) {
        NSString *identifier = IDENTIFIER_SHARE;
        _shareSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_SHARE inSection:0]];
        _shareSplitCell.shares = [self.expense.shares sortedArrayUsingDescriptors:nil];
        _shareSplitCell.type = DTShareSplitCellTypeShare;
        _shareSplitCell.backgroundColor = [UIColor yellowColor];
    }
    return _shareSplitCell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case INDEX_SPLIT_EQUALLY:
            return self.equallySplitCell;
        case INDEX_SPLIT_EXACTLY:
            return self.exactSplitCell;
        case INDEX_SPLIT_PERCENT:
            return self.perCentSplitCell;
        case INDEX_SPLIT_SHARE:
            return self.shareSplitCell;
            
        default:
            return nil;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, [DTShareSplitCell heightForNumberOfPersons:[self.expense.account.persons count]]);
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    self.segmentedControl.selectedSegmentIndex = indexPath.section;
}


@end
