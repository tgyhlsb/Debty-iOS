//
//  DTInstallation.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPerson.h"

@interface DTInstallation : NSObject

+ (DTPerson *)mainUser;
+ (void)setMainUser:(DTPerson *)mainUser;
+ (void)setMainUserWithInfo:(NSDictionary *)info;

+ (NSString *)authIdentifier;
+ (NSString *)authPassword;

@end
