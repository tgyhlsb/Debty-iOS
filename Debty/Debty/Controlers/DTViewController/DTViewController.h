//
//  DTViewController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTViewController : UIViewController

@property (nonatomic, strong) void (^closeBlock)(void);
@property (nonatomic, strong) void (^nextBlock)(void);

- (void)setCloseButtonVisible:(BOOL)visible;
- (void)setNextButtonVisible:(BOOL)visible;

@end
