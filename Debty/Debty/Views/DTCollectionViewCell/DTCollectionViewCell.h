//
//  DTCollectionViewCell.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTCollectionViewCell : UICollectionViewCell

+ (NSString *)reusableIdentifier;
+ (void)registerToCollectionView:(UICollectionView *)collectionView;

@end
