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
#import "DTTempUser.h"
#import "DTBackendManager.h"
#import "DTModelManager.h"
#import "DTInstallation.h"
#import "DTFacebookManager.h"

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
    
    self.loginView.readPermissions = FACEBOOK_PERMISSIONS;
    self.loginView.delegate = self;
    self.loginView.loginBehavior = FBSessionLoginBehaviorUseSystemAccountIfPresent;
}

#pragma mark - Button handlers

- (IBAction)facebookButtonHandler:(UIButton *)sender
{
    if ([DTFacebookManager isSessionOpen]) {
        [DTFacebookManager logOut];
    } else {
        [DTFacebookManager logIn];
    }
}


#pragma mark - FBLoginViewDelegate

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"loginView:handleError");
    NSLog(@"%@", error);
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{    
    [DTBackendManager identifyUserWithGraph:user success:^(NSURLSessionDataTask *task, NSDictionary *json) {
        NSDictionary *userInfo = [json objectForKey:@"user"];
        [DTInstallation setMainUserWithInfo:userInfo];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
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
