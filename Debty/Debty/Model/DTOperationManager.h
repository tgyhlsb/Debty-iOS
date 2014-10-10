//
//  DTOperationManager.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTOperationManager : NSObject

+ (void)useRoundedNumbers:(BOOL)rounded;

+ (NSDecimalNumber *)roundedNumber:(NSDecimalNumber *)number;

+ (NSDecimalNumber *)divide:(NSDecimalNumber *)first by:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)divideString:(NSString *)first by:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)divide:(NSDecimalNumber *)first byString:(NSString *)second;

+ (NSDecimalNumber *)multiply:(NSDecimalNumber *)first by:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)multiplyString:(NSString *)first by:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)multiply:(NSDecimalNumber *)first byString:(NSString *)second;

+ (NSDecimalNumber *)add:(NSDecimalNumber *)first to:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)addString:(NSString *)first to:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)add:(NSDecimalNumber *)first toString:(NSString *)second;

+ (NSDecimalNumber *)substract:(NSDecimalNumber *)first to:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)substractString:(NSString *)first to:(NSDecimalNumber *)second;
+ (NSDecimalNumber *)substract:(NSDecimalNumber *)first toString:(NSString *)second;

+ (NSString *)currencyStringWithDecimalNumber:(NSDecimalNumber *)decimalNumber;
+ (NSString *)currencyStringWithDecimalNumber:(NSDecimalNumber *)decimalNumber withLocaleCode:(NSString *)localeCode;


@end
