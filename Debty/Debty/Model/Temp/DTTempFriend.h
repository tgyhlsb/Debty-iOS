//
//  DTTempFriend.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 14/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTempFriend : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *facebookID;

+ (DTTempFriend *)randomFriend;

@end
