//
//  DTTempFriend.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTempFriend.h"

#define NAMES @[@"Mathieu", @"Ianic", @"Mael", @"Bob", @"Gaetan", @"Boobs"]

@implementation DTTempFriend

+ (DTTempFriend *)randomFriend
{
    DTTempFriend *friend = [[DTTempFriend alloc] init];
    friend.name = [NAMES objectAtIndex:(arc4random() % 5)];
    friend.facebookID = @"10204237736842333";
    return friend;
}

@end
