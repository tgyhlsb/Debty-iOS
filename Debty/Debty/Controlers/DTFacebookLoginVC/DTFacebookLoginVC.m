//
//  DTFacebookLoginVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFacebookLoginVC.h"
#import "DTInstallation.h"


#define NIB_NAME @"DTFacebookLoginVC"

@interface DTFacebookLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

@end

@implementation DTFacebookLoginVC

+ (DTFacebookLoginVC *)newController
{
    DTFacebookLoginVC *controller = [[DTFacebookLoginVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

- (void)updateView
{
    switch ([DTInstallation userState]) {
        case DTUserStateLoggedOut:
        {
            self.facebookButton.enabled = YES;
            [self.facebookButton setTitle:@"Log in" forState:UIControlStateNormal];
            break;
        }
            
        case DTUserStateFetchingInfo:
        {
            self.facebookButton.enabled = NO;
            [self.facebookButton setTitle:@"Loading..." forState:UIControlStateNormal];
            break;
        }
            
        case DTUserStateLoggedIn:
        {
            self.facebookButton.enabled = YES;
            [self.facebookButton setTitle:@"Log out" forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateView];
    
    [self registerToFacebookSessionNotifications];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Button handlers

- (IBAction)facebookButtonHandler:(UIButton *)sender
{
    if ([DTInstallation userState] == DTUserStateLoggedIn) {
        [DTInstallation logoutFromFacebook];
    } else {
        [DTInstallation loginWithFacebook];
    }
}

#pragma mark - FBDelegate

- (void)registerToFacebookSessionNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userStateChanged)
                                                 name:DTNotificationUserStateChanged
                                               object:nil];
}

- (void)userStateChanged
{
    switch ([DTInstallation userState]) {
        case DTUserStateLoggedOut:
        {
            [DTInstallation lockApplication];
            break;
        }
            
        case DTUserStateFetchingInfo:
        {
            // Nothing to do
            break;
        }
            
        case DTUserStateLoggedIn:
        {
            [DTInstallation unlockApplication];
            break;
        }
    }
    [self updateView];
}


@end
