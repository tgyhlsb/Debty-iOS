//
//  DTCreateAccountVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateAccountVC.h"

#define NIB_NAME @"DTCreateAccountVC"

@interface DTCreateAccountVC ()

@end

@implementation DTCreateAccountVC

+ (DTCreateAccountVC *)newController
{
    DTCreateAccountVC *controller = [[DTCreateAccountVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

@end
