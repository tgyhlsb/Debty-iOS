//
//  DTShareTypeVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareTypeVC.h"
#import "DTSharesEditorVC.h"

#define NIB_NAME @"DTShareTypeVC"

@interface DTShareTypeVC () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

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

#pragma mark - Handlers

- (IBAction)segmentedControlValueDidChange
{
    [self setViewControllerAtIndex:self.segmentedControl.selectedSegmentIndex];
}


#pragma mark - UIPageViewControllerDataSource

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
    DTShareTypeVC *viewController = [[pageViewController viewControllers] firstObject];
    self.segmentedControl.selectedSegmentIndex = [self.viewControllers indexOfObject:viewController];
}

@end
