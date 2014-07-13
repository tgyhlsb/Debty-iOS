//
//  DTNavigationController.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTNavigationController : UINavigationController

+ (instancetype)newNavigationController;

+ (DTNavigationController *)newControllerWithRootViewController:(UIViewController *)rootVC;

@end
