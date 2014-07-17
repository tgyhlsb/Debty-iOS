//
//  DTShareSplitCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCollectionViewCell.h"

#define IDENTIFIER_EQUALLY @"equallyCell"
#define IDENTIFIER_EXACTLY @"exactlyCell"
#define IDENTIFIER_PERCENT @"percentCell"
#define IDENTIFIER_SHARE   @"shareCell"

typedef NS_ENUM(NSInteger, DTShareSplitCellType) {
    DTShareSplitCellTypeEqually,
    DTShareSplitCellTypeExactly,
    DTShareSplitCellTypePercent,
    DTShareSplitCellTypeShare
};

@interface DTShareSplitCell : DTCollectionViewCell

@property (nonatomic) DTShareSplitCellType type;
@property (strong, nonatomic) NSArray *shares;

+ (CGFloat)heightForNumberOfPersons:(NSInteger)numberOfPersons;

@end
