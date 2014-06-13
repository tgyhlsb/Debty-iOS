//
//  DTTempExpense.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 13/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTempExpense : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *facebookID;

+ (DTTempExpense *)randomExpense;

@end
