//
//  DTShare+Serializer.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 21/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShare.h"

#define CLASS_NAME_SHARE @"DTShare"

@interface DTShare (Serializer)

+ (DTShare *)shareWithInfo:(NSDictionary *)info;
+ (DTShare *)sharesWithArray:(NSArray *)arrayInfo;

@end
