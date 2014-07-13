//
//  DTCollectionViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCollectionViewCell.h"

#define NIB_NAME @"DTCollectionViewCell"

@implementation DTCollectionViewCell

+ (NSString *)reusableIdentifier
{
    return NIB_NAME;
}

+ (void)registerToCollectionView:(UICollectionView *)collectionView
{
    UINib *nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:[DTCollectionViewCell reusableIdentifier]];
}

@end
