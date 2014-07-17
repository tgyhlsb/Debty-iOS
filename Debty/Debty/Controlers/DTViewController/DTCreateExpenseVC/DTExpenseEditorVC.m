//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTExpenseEditorVC.h"
#import "DTShareSplitCell.h"
#import "DTWhoPayedPickerVC.h"
#import "DTShare+Serializer.h" // ok, need to allocate temp shares

#define NIB_NAME @"DTExpenseEditorVC"

#define INDEX_SPLIT_EQUALLY 0
#define INDEX_SPLIT_EXACTLY 1
#define INDEX_SPLIT_PERCENT 2
#define INDEX_SPLIT_SHARE   3

@interface DTExpenseEditorVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DTWhoPayedPickerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;

@property (strong, nonatomic) DTShareSplitCell *equallySplitCell;
@property (strong, nonatomic) DTShareSplitCell *exactSplitCell;
@property (strong, nonatomic) DTShareSplitCell *perCentSplitCell;
@property (strong, nonatomic) DTShareSplitCell *shareSplitCell;

@end

@implementation DTExpenseEditorVC

+ (instancetype)newController
{
    DTExpenseEditorVC *controller = [[DTExpenseEditorVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

- (void)registerToGestureRecognizer
{
    UITapGestureRecognizer *whoPayedTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whoPayedViewTapHandler)];
    whoPayedTapRecognizer.numberOfTapsRequired = 1;
    whoPayedTapRecognizer.numberOfTouchesRequired = 1;
    [self.whoPayedView addGestureRecognizer:whoPayedTapRecognizer];
}

- (void)setWhoPayed:(DTPerson *)whoPayed
{
    _whoPayed = whoPayed;
    self.whoPayedLabel.text = whoPayed.firstName;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionViewHeightConstraint.constant = [DTShareSplitCell heightForNumberOfPersons:[self.account.persons count]];
    
    [self registerToGestureRecognizer];
    [DTShareSplitCell registerToCollectionView:self.collectionView];
}

#pragma mark - Handlers

- (IBAction)segmentedControlHandler
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.segmentedControl.selectedSegmentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)whoPayedViewTapHandler
{
    DTWhoPayedPickerVC *destination = [DTWhoPayedPickerVC newController];
    destination.account = self.account;
    destination.whoPayed = self.whoPayed;
    destination.delegate = self;
    [self.navigationController pushViewController:destination animated:YES];
}

#pragma mark - Expense Attributes

- (NSString *)expenseName
{
    return self.nameLabel.text;
}

- (NSDecimalNumber *)expenseAmount
{
    return [NSDecimalNumber decimalNumberWithString:self.amountLabel.text];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (DTShareSplitCell *)equallySplitCell
{
    if (!_equallySplitCell) {
        NSString *identifier = IDENTIFIER_EQUALLY;
        _equallySplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_EQUALLY inSection:0]];
        _equallySplitCell.persons = [DTShare sharesForExpense:<#(DTExpense *)#>;
        _equallySplitCell.type = DTShareSplitCellTypeEqually;
    }
    return _equallySplitCell;
}

- (DTShareSplitCell *)exactSplitCell
{
    if (!_exactSplitCell) {
        NSString *identifier = IDENTIFIER_EXACTLY;
        _exactSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_EXACTLY inSection:0]];
        _exactSplitCell.persons = [self.account.persons sortedArrayUsingDescriptors:nil];
        _exactSplitCell.type = DTShareSplitCellTypeExactly;
    }
    return _exactSplitCell;
}

- (DTShareSplitCell *)perCentSplitCell
{
    if (!_perCentSplitCell) {
        NSString *identifier = IDENTIFIER_PERCENT;
        _perCentSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_PERCENT inSection:0]];
        _perCentSplitCell.persons = [self.account.persons sortedArrayUsingDescriptors:nil];
        _perCentSplitCell.type = DTShareSplitCellTypePercent;
    }
    return _perCentSplitCell;
}

- (DTShareSplitCell *)shareSplitCell
{
    if (!_shareSplitCell) {
        NSString *identifier = IDENTIFIER_SHARE;
        _shareSplitCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForRow:INDEX_SPLIT_SHARE inSection:0]];
        _shareSplitCell.persons = [self.account.persons sortedArrayUsingDescriptors:nil];
        _shareSplitCell.type = DTShareSplitCellTypeShare;
    }
    return _shareSplitCell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
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
    return CGSizeMake(320, [DTShareSplitCell heightForNumberOfPersons:[self.account.persons count]]);
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    self.segmentedControl.selectedSegmentIndex = indexPath.row;
}

#pragma mark - DTWhoPayedPickerDelegate

- (void)whoPayedPickerDidSelectPerson:(DTPerson *)person
{
    self.whoPayed = person;
}

@end
