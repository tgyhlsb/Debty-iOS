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

@interface DTShareCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end

@implementation DTShareCell

- (void)setType:(DTShareCellType)type
{
    _type = type;
    
    self.nameLabel.text = self.share.person.firstName;
    switch (type) {
        case DTShareCellTypeEqually:
        {
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"";
            break;
        }
            
        case DTShareCellTypeExactly:
        {
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0,00";
            self.unitLabel.text = @"€";
            break;
        }
            
        case DTShareCellTypePercent:
        {
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0";
            self.unitLabel.text = @"%";
            break;
        }
            
        case DTShareCellTypeShare:
        {
            self.unitLabel.text = @"";
            self.valueTextField.text = @"";
            self.valueTextField.placeholder = @"0";
            self.unitLabel.text = @"share";
            break;
        }
            
        default:
            break;
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
