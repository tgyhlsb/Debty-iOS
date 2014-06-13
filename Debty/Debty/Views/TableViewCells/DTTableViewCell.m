//
//  DTTableViewCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTTableViewCell.h"

@implementation DTTableViewCell

+ (void)registerToTableView:(UITableView *)tableView
{
    [[[NSException alloc] initWithName:@"DTTableViewCell" reason:@"This is an abstract class, you can't use [DTTableViewCell registerToTableView:]" userInfo:nil] raise];
}

+(NSString *)reusableIdentifier
{
    [[[NSException alloc] initWithName:@"DTTableViewCell" reason:@"This is an abstract class, you can't use [DTTableViewCell reusableIdentifier]" userInfo:nil] raise];
    return nil;
}

+ (CGFloat)height
{
    [[[NSException alloc] initWithName:@"DTTableViewCell" reason:@"This is an abstract class, you can't use [DTTableViewCell height]" userInfo:nil] raise];
    return 0.0;
}

@end
