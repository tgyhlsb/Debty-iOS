//
//  DTCreateExpenseVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateExpenseVC.h"
#import "DTShareSplitCell.h"

#define NIB_NAME @"DTCreateExpenseVC"

@interface DTCreateExpenseVC () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;

@end

@implementation DTCreateExpenseVC

+ (instancetype)newController
{
    DTCreateExpenseVC *controller = [[DTCreateExpenseVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DTShareSplitCell registerToCollectionView:self.collectionView];
}

#pragma mark - Handlers

- (IBAction)segmentedControlHandler
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.segmentedControl.selectedSegmentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
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

@end
