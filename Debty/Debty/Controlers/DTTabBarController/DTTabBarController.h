//
//  DTTabBarController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAccount+Helpers.h"

@interface DTTabBarController : UITabBarController

+ (DTTabBarController *)sharedController;

+ (void)setViewForAccount:(DTAccount *)account animated:(BOOL)animated;

@end
