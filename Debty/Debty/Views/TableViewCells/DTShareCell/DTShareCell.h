//
//  DTShareCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"
#import "DTShare+Helpers.h"

@protocol DTShareCellDelegate;

@interface DTShareCell : DTTableViewCell

@property (weak, nonatomic) id<DTShareCellDelegate> delegate;

@property (nonatomic) DTShareType type;
@property (strong, nonatomic) DTShare *share;
@property (strong, nonatomic) NSDecimalNumber *value;

- (void)becomeFirstResponder;
- (void)resignFirstResponder;

@end

@protocol DTShareCellDelegate <NSObject>

- (BOOL)shareCellShouldReturn:(DTShareCell *)cell;
- (void)shareCellValueDidChange:(DTShareCell *)cell;

@end
