//
//  DTShareCell.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/07/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTShareCell.h"
#import "DTPerson+Helpers.h"

#define NIB_NAME @"DTShareCell"
#define HEIGHT 44

@interface DTShareCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end

@implementation DTShareCell

- (void)becomeFirstResponder
{
    [self.valueTextField becomeFirstResponder];
}

- (void)resignFirstResponder
{
    [self.valueTextField resignFirstResponder];
}

#pragma mark - View life cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self registerForTextFieldNotification];
    
    self.value = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler)];
    [self addGestureRecognizer:tapRecognizer];
}

#pragma mark - Setters

- (void)setType:(DTShareType)type
{
    _type = type;
    
    self.nameLabel.text = self.share.person.firstName;
    switch (type) {
        case DTShareTypeEqually:
        {
            self.unitLabel.hidden = YES;
            self.valueTextField.hidden = YES;
            break;
        }
            
        case DTShareTypeExactly:
        {
            self.unitLabel.hidden = NO;
            self.valueTextField.hidden = NO;
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0,00";
            self.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            self.unitLabel.text = @"€";
            break;
        }
            
        case DTShareTypePercent:
        {
            self.unitLabel.hidden = NO;
            self.valueTextField.hidden = NO;
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0";
            self.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            self.unitLabel.text = @"%";
            break;
        }
            
        case DTShareTypeShare:
        {
            self.unitLabel.hidden = NO;
            self.valueTextField.hidden = NO;
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0";
            self.valueTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.unitLabel.text = @"share";
            break;
        }
            
        default:
            break;
    }
}

- (void)setValue:(NSDecimalNumber *)value
{

    _value = value;
    
    // Update view if type is Equally
    if (self.type == DTShareTypeEqually) {
        if ([value isEqualToNumber:@0]) {
            self.accessoryType = UITableViewCellAccessoryNone;
        } else {
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    // Notiffy delegate
    if ([self.delegate respondsToSelector:@selector(shareCellValueDidChange:)]) {
        [self.delegate shareCellValueDidChange:self];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(shareCellShouldReturn:)]) {
        return [self.delegate shareCellShouldReturn:self];
    }
    return YES;
}

- (void)valueTextFieldValueDidChange
{
    self.value = [NSDecimalNumber decimalNumberWithString:self.valueTextField.text];
}

- (void)registerForTextFieldNotification
{
    [self.valueTextField addTarget:self
                            action:@selector(valueTextFieldValueDidChange)
                  forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - Handlers

- (void)tapHandler
{
    if (self.type == DTShareTypeEqually) {
        self.value = [self.value boolValue] ? [NSDecimalNumber decimalNumberWithString:@"0"] : [NSDecimalNumber decimalNumberWithString:@"1"];
    }
}

#pragma mark - Subclass methods

+ (NSString *)reusableIdentifier
{
    return NIB_NAME;
}

+ (void)registerToTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[DTShareCell reusableIdentifier]];
}

+ (CGFloat)height
{
    return HEIGHT;
}


@end
