//
//  DTFacebookLoginVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFacebookLoginVC.h"
#import <FacebookSDK/FacebookSDK.h>

#define NIB_NAME @"DTFacebookLoginVC"

@interface DTFacebookLoginVC () <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@end

@implementation DTFacebookLoginVC

+ (DTFacebookLoginVC *)newController
{
    DTFacebookLoginVC *controller = [[DTFacebookLoginVC alloc] initWithNibName:NIB_NAME bundle:nil];
    return controller;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.loginView.delegate = self;
}

#pragma mark - FBLoginViewDelegate

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    
}

@end
