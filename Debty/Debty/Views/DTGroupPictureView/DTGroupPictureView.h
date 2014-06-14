//
//  MultiImageView.h
//  GLGroupChatPicView
//
//  Created by Gautam Lodhiya on 30/04/14.
//  Copyright (c) 2014 Gautam Lodhiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DTGroupPictureView : UIView
@property (nonatomic, assign) NSUInteger totalEntries;

- (void)addUserID:(NSString *)userID withName:(NSString *)name;

- (void)updateLayout;
- (void)reset;
@end
