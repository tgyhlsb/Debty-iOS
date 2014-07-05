//
//  DTViewController.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTViewController.h"

@interface DTViewController ()

@property (nonatomic, strong) UIBarButtonItem *closeButton;
@property (nonatomic, strong) UIBarButtonItem *nextButton;

@end

@implementation DTViewController



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View methods

- (void)setCloseButtonVisible:(BOOL)visible
{
    if (visible) {
        self.navigationItem.leftBarButtonItem = self.closeButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)setNextButtonVisible:(BOOL)visible
{
    if (visible) {
        self.navigationItem.rightBarButtonItem = self.nextButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - Getters

- (UIBarButtonItem *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeButtonHandler)];
    }
    return _closeButton;
}

- (UIBarButtonItem *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextButtonHandler)];
    }
    return _nextButton;
}

#pragma mark - Handlers

- (void)closeButtonHandler
{
    NSLog(@"[DTViewController closeButtonHandler]");
    if (self.closeBlock) {
        self.closeBlock();
        self.closeBlock = nil;
    }
}

- (void)nextButtonHandler
{
    NSLog(@"[DTViewController nextButtonHandler]");
    if (self.nextBlock) {
        self.nextBlock();
    }
}



@end
