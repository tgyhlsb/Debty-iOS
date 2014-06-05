//
//  DTAppDelegate.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (void)setLoggedIn;
+ (void)setLoggedOut;

@end
