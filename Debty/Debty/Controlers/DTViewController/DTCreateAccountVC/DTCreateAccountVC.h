//
//  DTCreateAccountVC.h
//  Debty
//
//  Created by Tanguy Hélesbeux on 15/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTViewController.h"
#import "DTAccountDraft.h"

@interface DTCreateAccountVC : DTViewController

@property (strong, nonatomic) DTAccountDraft *accountDraft;

+ (DTCreateAccountVC *)newController;

@end
