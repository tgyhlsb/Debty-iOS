//
//  DTShareTypeVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 17/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTViewController.h"
#import "DTExpenseCache.h"

@protocol DTShareTypeDelegate;

@interface DTShareTypeVC : DTViewController

@property (weak, nonatomic) id<DTShareTypeDelegate> delegate;

@property (strong, nonatomic) DTExpenseCache *expenseCache;

@end

@protocol DTShareTypeDelegate <NSObject>

- (void)shareTypeVCDidUpdateExpenseCache:(DTExpenseCache *)expenseCache;

@end
