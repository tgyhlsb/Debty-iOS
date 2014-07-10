//
//  DTExpenseTableViewCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"
#import "DTAccount+Serializer.h"

@interface DTAccountTableViewCell : DTTableViewCell

@property (strong, nonatomic) DTAccount *account;

@end
