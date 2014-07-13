//
//  DTExpenseTableViewCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"
#import "DTExpense.h"

@interface DTExpenseTableViewCell : DTTableViewCell

@property (strong, nonatomic) DTExpense *expense;

@end
