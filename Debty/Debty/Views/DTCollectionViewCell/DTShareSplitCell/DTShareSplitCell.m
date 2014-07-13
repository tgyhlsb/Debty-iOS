//
//  DTShareSplitCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareSplitCell.h"

#define NIB_NAME @"DTShareSplitCell"

@implementation DTShareSplitCell

- (void)setColor:(int)n
{
    switch (n%4) {
        case 0:
            self.backgroundColor = [UIColor redColor];
            break;
        case 1:
            self.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case 4:
            self.backgroundColor = [UIColor blueColor];
            break;
            
        default:
            break;
    }
}

#pragma mark - Subclass methods

+ (NSString *)reusableIdentifier
{
    return NIB_NAME;
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView
{
    UINib *nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:[DTShareSplitCell reusableIdentifier]];
}


@end
