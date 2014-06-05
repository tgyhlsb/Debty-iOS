//
//  DTTestVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTestVC.h"

#define NIB_NAME @"DTTestVC"

@interface DTTestVC ()

@end

@implementation DTTestVC

+ (DTTestVC *)newController
{
    DTTestVC *controller = [[DTTestVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

@end
