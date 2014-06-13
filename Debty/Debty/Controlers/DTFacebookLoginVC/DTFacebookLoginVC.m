//
//  DTFacebookLoginVC.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 06/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTFacebookLoginVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DTAppDelegate.h"

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
    NSLog(@"loginView:handleError");
    NSLog(@"%@", error);
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@", user);
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    NSLog(@"loginViewShowingLoggedInUser:");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DTAppDelegate setLoggedIn];
    });
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    NSLog(@"loginViewShowingLoggedOutUser:");
    [DTAppDelegate setLoggedOut];
}

@end
