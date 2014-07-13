//
//  DTAppDelegate.m
//  Debty
//
//  Created by Tanguy Hélesbeux on 05/06/2014.
//  Copyright (c) 2014 Debty. All rights reserved.
//

#import "DTAppDelegate.h"
#import "DTTabBarController.h"
#import "DTFacebookLoginVC.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "DTInstallation.h"
#import "DTFacebookManager.h"

@interface DTAppDelegate()

@property (nonatomic, strong) DTTabBarController *tabBarController;
@property (nonatomic, strong) DTFacebookLoginVC *facebookLoginVC;

@end

@implementation DTAppDelegate



+ (DTAppDelegate *)sharedDelegate
{
    return (DTAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)setRootViewControllerAnimated:(UIViewController *)viewController
{
    if (![self.window.rootViewController isEqual:viewController]) {
        
        [UIView transitionWithView:self.window
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            self.window.rootViewController = viewController;
                        }
                        completion:nil];
    }
}

- (void)setLoggedIn
{
    [self setRootViewControllerAnimated:self.tabBarController];
}

+ (void)setLoggedIn
{
    [[DTAppDelegate sharedDelegate] setLoggedIn];
}

- (void)setLoggedOut
{
    [self setRootViewControllerAnimated:self.facebookLoginVC];
}

+(void)setLoggedOut
{
    [[DTAppDelegate sharedDelegate] setLoggedOut];
}

#pragma mark - Default methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([DTInstallation canUnlockApplication]) {
        [DTInstallation loginWithFacebook];
        self.window.rootViewController = self.tabBarController;
    } else {
        self.window.rootViewController = self.facebookLoginVC;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    [DTFacebookManager handleAppColdStart];
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

#pragma mark - Getters

- (DTFacebookLoginVC *)facebookLoginVC
{
    if (!_facebookLoginVC) {
        _facebookLoginVC = [DTFacebookLoginVC newController];
    }
    return _facebookLoginVC;
}

- (DTTabBarController *)tabBarController
{
    if (!_tabBarController) {
        _tabBarController = [DTTabBarController sharedController];
    }
    return _tabBarController;
}
@end
