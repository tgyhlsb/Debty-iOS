//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateExpenseVC.h"
#import "DTShareSplitCell.h"
#import "DTWhoPayedPickerVC.h"

#define NIB_NAME @"DTCreateExpenseVC"

@interface DTCreateExpenseVC () <UICollectionViewDataSource, UICollectionViewDelegate, DTWhoPayedPickerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *whoPayedView;
@property (weak, nonatomic) IBOutlet UILabel *whoPayedLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;

@end

@implementation DTCreateExpenseVC

+ (instancetype)newController
{
    DTCreateExpenseVC *controller = [[DTCreateExpenseVC alloc] initWithNibName:NIB_NAME bundle:nil];
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [DTShareSplitCell reusableIdentifier];
    DTShareSplitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    static int n = 0;
    [cell setColor:n++];
    
    return cell;
    
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
