//
//  DTOperationManager.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 09/10/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTOperationManager.h"

static NSDecimalNumberHandler *sharedDecimalHandler;
static NSNumberFormatter *sharedNumberFormatter;
static BOOL useRoundedNumber = NO;

@interface DTOperationManager()

@property (strong, nonatomic) NSDecimalNumberHandler *decimalHandler;
@property (nonatomic) BOOL useRoundedNumber;

@end

@implementation DTOperationManager

+ (NSDecimalNumberHandler *)sharedDecimalHandler
{
    if (!sharedDecimalHandler) {
        
        sharedDecimalHandler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                              scale:2
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:NO];
    }
    return sharedDecimalHandler;
}

+ (NSNumberFormatter *)sharedNumberFormatter
{
    if (!sharedNumberFormatter) {
        sharedNumberFormatter = [[NSNumberFormatter alloc] init];
        [sharedNumberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    }
    return sharedNumberFormatter;
}

+ (void)useRoundedNumbers:(BOOL)rounded
{
    useRoundedNumber = rounded;
}

#pragma mark - Operations

+ (NSDecimalNumber *)roundedNumber:(NSDecimalNumber *)number
{
    return [number decimalNumberByRoundingAccordingToBehavior:[DTOperationManager sharedDecimalHandler]];
}

#pragma mark Divide

+ (NSDecimalNumber *)divide:(NSDecimalNumber *)first by:(NSDecimalNumber *)second
{
    if (!second || [second isEqualToNumber:[NSDecimalNumber zero]]) {
        NSLog(@"Division by zero occured");
        return [NSDecimalNumber zero];
    } else if (useRoundedNumber) {
        return [first decimalNumberByDividingBy:second withBehavior:[DTOperationManager sharedDecimalHandler]];
    } else {
        return [first decimalNumberByDividingBy:second];
    }
}

+ (NSDecimalNumber *)divide:(NSDecimalNumber *)first byString:(NSString *)second
{
    return [DTOperationManager divide:first by:[NSDecimalNumber decimalNumberWithString:second]];
}

+ (NSDecimalNumber *)divideString:(NSString *)first by:(NSDecimalNumber *)second
{
    return [DTOperationManager divide:[NSDecimalNumber decimalNumberWithString:first] by:second];
}

#pragma mark Multiply

+ (NSDecimalNumber *)multiply:(NSDecimalNumber *)first by:(NSDecimalNumber *)second
{
    if (useRoundedNumber) {
        return [first decimalNumberByMultiplyingBy:second withBehavior:[DTOperationManager sharedDecimalHandler]];
    } else {
        return [first decimalNumberByMultiplyingBy:second];
    }
}

+ (NSDecimalNumber *)multiply:(NSDecimalNumber *)first byString:(NSString *)second
{
    return [DTOperationManager multiply:first by:[NSDecimalNumber decimalNumberWithString:second]];
}

+ (NSDecimalNumber *)multiplyString:(NSString *)first by:(NSDecimalNumber *)second
{
    return [DTOperationManager multiply:[NSDecimalNumber decimalNumberWithString:first] by:second];
}

#pragma mark Add

+ (NSDecimalNumber *)add:(NSDecimalNumber *)first to:(NSDecimalNumber *)second
{
    if (useRoundedNumber) {
        return [first decimalNumberByAdding:second withBehavior:[DTOperationManager sharedDecimalHandler]];
    } else {
        return [first decimalNumberByAdding:second];
    }
}

+ (NSDecimalNumber *)add:(NSDecimalNumber *)first toString:(NSString *)second
{
    return [DTOperationManager add:first to:[NSDecimalNumber decimalNumberWithString:second]];
}

+ (NSDecimalNumber *)addString:(NSString *)first to:(NSDecimalNumber *)second
{
    return [DTOperationManager add:[NSDecimalNumber decimalNumberWithString:first] to:second];
}

#pragma mark Substract

+ (NSDecimalNumber *)substract:(NSDecimalNumber *)first to:(NSDecimalNumber *)second
{
    if (useRoundedNumber) {
        return [second decimalNumberBySubtracting:first withBehavior:[DTOperationManager sharedDecimalHandler]];
    } else {
        return [second decimalNumberBySubtracting:first];
    }
}

+ (NSDecimalNumber *)substract:(NSDecimalNumber *)first toString:(NSString *)second
{
    return [DTOperationManager substract:first to:[NSDecimalNumber decimalNumberWithString:second]];
}

+ (NSDecimalNumber *)substractString:(NSString *)first to:(NSDecimalNumber *)second
{
    return [DTOperationManager substract:[NSDecimalNumber decimalNumberWithString:first] to:second];
}

#pragma mark - Currency

+ (NSString *)currencyStringWithDecimalNumber:(NSDecimalNumber *)decimalNumber
{
    return [DTOperationManager currencyStringWithDecimalNumber:decimalNumber
                                              withLocaleCode:nil];
}

+ (NSString *)currencyStringWithDecimalNumber:(NSDecimalNumber *)decimalNumber withLocaleCode:(NSString *)localeCode
{
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:localeCode];
    return [DTOperationManager currencyStringWithDecimalNumber:decimalNumber withLocale:locale];
}

+ (NSString *)currencyStringWithDecimalNumber:(NSDecimalNumber *)decimalNumber withLocale:(NSLocale *)locale
{
    if (!locale) {
        locale = [NSLocale currentLocale];
    }
    
    NSNumberFormatter *numberFormatter = [DTOperationManager sharedNumberFormatter];
    [numberFormatter setLocale:locale];
    return [numberFormatter stringFromNumber:decimalNumber];
}


@end
