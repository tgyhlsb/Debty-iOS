//
//  DTShareCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"
#import "DTPerson.h"


typedef NS_ENUM(NSInteger, DTShareCellType) {
    DTShareCellTypeEqually,
    DTShareCellTypeExactly,
    DTShareCellTypePercent,
    DTShareCellTypeShare
};

@interface DTShareCell : DTTableViewCell

@property (nonatomic) DTShareCellType type;
@property (strong, nonatomic) DTPerson *person;
@property (strong, nonatomic) NSNumber *value;

@end
