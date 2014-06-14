//
//  DTFriendsPickerVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFriendsPickerVC.h"

#define NIB_NAME @"DTFriendsPickerVC"

@interface DTFriendsPickerVC ()

@end

@implementation DTFriendsPickerVC

+ (DTFriendsPickerVC *)newController
{
    DTFriendsPickerVC *controller = [[DTFriendsPickerVC alloc] initWithNibName:NIB_NAME bundle:nil];
    controller.title = @"Pick a friend";
    return controller;
}

@end
