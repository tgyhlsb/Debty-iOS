//
//  DTShareTypeVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareTypeVC.h"
#import "DTSharesEditorVC.h"
#import "DTExpense+Helpers.h"

#define NIB_NAME @"DTShareTypeVC"

@interface DTShareTypeVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIBarPositioningDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *viewControllers;

@property (weak, nonatomic) IBOutlet UIView *pageControllerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@end

@implementation DTShareTypeVC

+ (instancetype)newController
{
    DTShareTypeVC *controller = [[DTShareTypeVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark Getters & Setters

- (void)setExpense:(DTExpense *)expense
{
    _expense = expense;
    
    // update all VCs
    [self.viewControllers makeObjectsPerformSelector:@selector(setExpense:) withObject:self.expense];
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        DTSharesEditorVC *equallyVC = [DTSharesEditorVC newController];
        equallyVC.type = DTShareTypeEqually;
        equallyVC.expense = self.expense;
        
        DTSharesEditorVC *exactlyVC = [DTSharesEditorVC newController];
        exactlyVC.type = DTShareTypeExactly;
        exactlyVC.expense = self.expense;
        
        DTSharesEditorVC *percentVC = [DTSharesEditorVC newController];
        percentVC.type = DTShareTypePercent;
        percentVC.expense = self.expense;
        
        DTSharesEditorVC *shareVC = [DTSharesEditorVC newController];
        shareVC.type = DTShareTypeShare;
        shareVC.expense = self.expense;
        
        _viewControllers = [NSArray arrayWithObjects:equallyVC, exactlyVC, percentVC, shareVC, nil];
    }
    return _viewControllers;
}

- (void)setViewControllerAtIndex:(NSInteger)index
{
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    [self.pageController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)setViewForShareType:(DTShareType)type
{
    [self setViewControllerAtIndex:type];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.pageController.view.frame = self.pageControllerView.frame;
    
    [self setViewControllerAtIndex:0];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setViewForShareType:self.expense.type];
    self.segmentedControl.selectedSegmentIndex = self.expense.type;
}

#pragma mark - Handlers

- (IBAction)segmentedControlValueDidChange
{
    [self setViewForShareType:self.segmentedControl.selectedSegmentIndex];
}

- (IBAction)cancelButtonHandler:(UIBarButtonItem *)sender
{
    [self selfDissmiss];
}

- (IBAction)doneButtonHandler:(UIBarButtonItem *)sender
{
    if ([self shouldSaveShares]) {
        [self selfDissmiss];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"invalid shares" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil] show];
    }
}

- (BOOL)shouldSaveShares
{
    DTSharesEditorVC *activeVC = [self activeViewController];
    
    if ([activeVC areSharesValid]) {
        [activeVC setSharesFromValues];
        return YES;
    }
    
    return NO;
}

- (void)selfDissmiss
{
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (DTSharesEditorVC *)activeViewController
{
    return [[self.pageController viewControllers] firstObject];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    if (index <= 0) {
        return nil;
    }
    
    return [self.viewControllers objectAtIndex:index-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    if (index+1 >= [self.viewControllers count]) {
        return nil;
    }
    
    return [self.viewControllers objectAtIndex:index+1];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    DTSharesEditorVC *viewController = [self activeViewController];
    self.segmentedControl.selectedSegmentIndex = [self.viewControllers indexOfObject:viewController];
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end
