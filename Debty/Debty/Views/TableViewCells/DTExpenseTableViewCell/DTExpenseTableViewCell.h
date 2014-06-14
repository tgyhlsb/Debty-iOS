//
//  DTExpenseTableViewCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"
#import "DTTempExpense.h"

@interface DTExpenseTableViewCell : DTTableViewCell

@property (strong, nonatomic) DTTempExpense *expense;

@end
