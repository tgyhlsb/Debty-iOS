//
//  DTFacebookLoginVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFacebookLoginVC.h"
#import <FacebookSDK/FacebookSDK.h>

#define NIB_NAME @"DTFacebookLoginVC"

@interface DTFacebookLoginVC ()

@end

@implementation DTFacebookLoginVC

+ (DTFacebookLoginVC *)newController
{
    DTFacebookLoginVC *controller = [[DTFacebookLoginVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

@end
