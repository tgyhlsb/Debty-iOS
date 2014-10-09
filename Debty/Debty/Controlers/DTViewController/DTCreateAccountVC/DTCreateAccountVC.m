//
//  DTCreateAccountVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTCreateAccountVC.h"

#define NIB_NAME @"DTCreateAccountVC"

@interface DTCreateAccountVC () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *currencyPicker;

@end

@implementation DTCreateAccountVC

+ (DTCreateAccountVC *)newController
{
    DTCreateAccountVC *controller = [[DTCreateAccountVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currencyPicker.delegate = self;
    self.currencyPicker.dataSource = self;
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self registerToTextFieldNotifications];
}

#pragma mark - Set up

- (void)registerToTextFieldNotifications
{
    [self.nameTextField addTarget:self action:@selector(nameTextFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Handlers

- (void)nameTextFieldValueDidChange
{
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[NSLocale availableLocaleIdentifiers] count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *localeIdentifier = [[NSLocale availableLocaleIdentifiers] objectAtIndex:row];
    NSLocale *selectedLocale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    NSLocale *appLocale = [NSLocale currentLocale];
    //  country code and name (in app's locale)
    NSString *countryCode = [selectedLocale objectForKey:NSLocaleCountryCode];
    NSString *countryName = [appLocale displayNameForKey:NSLocaleCountryCode value:countryCode];
    //  symbol and currency code
    NSString *localCurrencySymbol = [selectedLocale objectForKey:NSLocaleCurrencySymbol];
    NSString *currencyCode = [selectedLocale objectForKey:NSLocaleCurrencyCode];
    NSString *title = [NSString stringWithFormat:@"%@ %@: %@ (%@)", countryCode, countryName, localCurrencySymbol, currencyCode];
    
    return title;
}

@end
