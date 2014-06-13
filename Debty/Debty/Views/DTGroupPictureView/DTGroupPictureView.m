//
//  MultiImageView.m
//  GLGroupChatPicView
//
//  Created by Gautam Lodhiya on 30/04/14.
//  Copyright (c) 2014 Gautam Lodhiya. All rights reserved.
//

#import "DTGroupPictureView.h"

@interface DTGroupPictureView()
@property (nonatomic, assign) NSUInteger totalCount;

@property (nonatomic, strong) NSMutableArray *userIDs;
@property (nonatomic, strong) FBProfilePictureView *imageLayer1;
@property (nonatomic, strong) FBProfilePictureView *imageLayer2;
@property (nonatomic, strong) FBProfilePictureView *imageLayer3;
@property (nonatomic, strong) FBProfilePictureView *imageLayer4;
@property (nonatomic, strong) UIImageView *numberView;

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *shadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize shadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat shadowBlur UI_APPEARANCE_SELECTOR;
@end

@implementation DTGroupPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}


#pragma mark -
#pragma mark - Public helpers

- (void)addUserID:(NSString *)userID withName:(NSString *)name
{
    if (self.userIDs.count < 4) {
        if (self.userIDs.count == 3 && self.totalEntries > 4) {
            NSString *totalStr = [NSString stringWithFormat:@"%ld", (unsigned long)self.totalEntries];
            if (totalStr) {
//                [self addInitials:totalStr];
            }
            return;
        }
        
        
        self.totalCount++;
        
        if (userID) {
            [self.userIDs addObject:userID];
            
        } else if (name) {
            if (name && name.length) {
                NSString *firstLetter = [[name substringToIndex:1] capitalizedString];
                [self addInitials:firstLetter];
            }
        }
        
    } else {
        if (self.totalEntries > 0) {
            NSString *totalStr = [NSString stringWithFormat:@"%ld", (unsigned long)self.totalEntries];
            if (totalStr) {
                [self.userIDs removeLastObject];
                [self addInitials:totalStr];
            }
            
        } else {
            if (self.totalCount >= 4) {
                self.totalCount++;
                NSString *totalStr = [NSString stringWithFormat:@"%ld", (unsigned long)self.totalCount];
                if (totalStr) {
                    [self.userIDs removeLastObject];
                    [self addInitials:totalStr];
                }
            }
        }
    }
}

- (void)addInitials:(NSString *)initials
{
    if (initials && initials.length) {
        CGFloat width = 0;
        CGSize size = self.frame.size;
        
        if (self.totalCount == 0) {
            width = floorf(size.width);
        } else if (self.totalCount == 1) {
            width = floorf(size.width * 0.7);
        } else if (self.totalCount == 2) {
            width = floorf(size.width * 0.5);
        } else if (self.totalCount > 2) {
            width = floorf(size.width * 0.5);
        }
        
        CGFloat fontSize = initials.length == 1 ? width * 0.6 : width * 0.5;
        UIImage *image = [self imageFromText:initials withCanvasSize:CGSizeMake(width, width) andFontSize:fontSize];
        if (image) {
            [self.userIDs addObject:image];
        }
    }
}

- (void)reset
{
    self.totalEntries = 0;
    self.totalCount = 0;
    [self.userIDs removeAllObjects];
    [self resetLayers];
}

- (void)updateLayout
{
    [self resetLayers];
    
    if (self.userIDs) {
        CGFloat width = 0;
        CGSize size = self.frame.size;
        
        if (self.userIDs.count == 1) {
            width = floorf(size.width);
            
            self.imageLayer1.profileID = [self.userIDs objectAtIndex:0];
            self.imageLayer1.frame = CGRectMake(0, 0, width, width);
            self.imageLayer1.layer.cornerRadius = width * 0.5;
            self.imageLayer1.hidden = NO;
            
        } else if (self.userIDs.count == 2) {
            width = floorf(size.width * 0.7);
            
            self.imageLayer1.profileID = [self.userIDs objectAtIndex:0];
            self.imageLayer1.frame = CGRectMake(0, (size.height - width), width, width);
            self.imageLayer1.layer.cornerRadius = width * 0.5;
            self.imageLayer1.layer.borderWidth = self.borderWidth + 0.5f;
            self.imageLayer1.layer.zPosition = 1;
            self.imageLayer1.hidden = NO;
            
            self.imageLayer2.profileID = [self.userIDs objectAtIndex:1];
            self.imageLayer2.frame = CGRectMake((size.width - width), 0, width, width);
            self.imageLayer2.layer.cornerRadius = width * 0.5;
            self.imageLayer2.layer.borderWidth = self.borderWidth - 0.5f;
            self.imageLayer2.layer.zPosition = 0;
            self.imageLayer2.hidden = NO;
            
        } else if (self.userIDs.count == 3) {
            width = floorf(size.width * 0.5);
            
            self.imageLayer1.profileID = [self.userIDs objectAtIndex:0];
            self.imageLayer1.frame = CGRectMake((size.width - width) * 0.5, 1.5, width, width);
            self.imageLayer1.layer.cornerRadius = width * 0.5;
            self.imageLayer1.hidden = NO;
            
            self.imageLayer2.profileID = [self.userIDs objectAtIndex:1];
            self.imageLayer2.frame = CGRectMake(0, (size.height - width) - 1.5, width, width);
            self.imageLayer2.layer.cornerRadius = width * 0.5;
            self.imageLayer2.hidden = NO;
            
            self.imageLayer3.profileID = [self.userIDs objectAtIndex:2];
            self.imageLayer3.frame = CGRectMake((size.width - width), (size.height - width) - 1.5, width, width);
            self.imageLayer3.layer.cornerRadius = width * 0.5;
            self.imageLayer3.hidden = NO;
            
        } else if (self.userIDs.count > 3) {
            width = floorf(size.width * 0.5);
            
            self.imageLayer1.profileID = [self.userIDs objectAtIndex:0];
            self.imageLayer1.frame = CGRectMake(0, 0, width, width);
            self.imageLayer1.layer.cornerRadius = width * 0.5;
            self.imageLayer1.hidden = NO;
            
            self.imageLayer2.profileID = [self.userIDs objectAtIndex:1];
            self.imageLayer2.frame = CGRectMake((size.width - width), 0, width, width);
            self.imageLayer2.layer.cornerRadius = width * 0.5;
            self.imageLayer2.hidden = NO;
            
            self.imageLayer3.profileID = [self.userIDs objectAtIndex:2];
            self.imageLayer3.frame = CGRectMake(0, (size.height - width), width, width);
            self.imageLayer3.layer.cornerRadius = width * 0.5;
            self.imageLayer3.hidden = NO;
            
            UIView *view4 = nil;
            if ([[self.userIDs objectAtIndex:3] isKindOfClass:[NSString class]]) {
                self.imageLayer4.profileID = [self.userIDs objectAtIndex:3];
                view4 = self.imageLayer4;
            } else {
                self.numberView.image = [self.userIDs objectAtIndex:3];
                view4 = self.numberView;
            }
            view4.frame = CGRectMake((size.width - width), (size.height - width), width, width);
            view4.layer.cornerRadius = width * 0.5;
            view4.hidden = NO;
        }
    }
}


#pragma mark -
#pragma mark - Private helpers

- (void)setup
{
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 1.f;
    self.shadowColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:.75f];
    self.shadowOffset = CGSizeMake(0, 0);
    self.shadowBlur = 2.f;
    
    self.userIDs = [@[] mutableCopy];
}

- (void)resetLayers
{
    self.imageLayer1.hidden = YES;
    self.imageLayer2.hidden = YES;
    self.imageLayer3.hidden = YES;
    self.imageLayer4.hidden = YES;
    
    self.imageLayer1.layer.borderWidth = self.borderWidth;
    self.imageLayer2.layer.borderWidth = self.borderWidth;
    self.imageLayer3.layer.borderWidth = self.borderWidth;
    self.imageLayer4.layer.borderWidth = self.borderWidth;
    
    self.imageLayer1.layer.zPosition = 0;
    self.imageLayer2.layer.zPosition = 0;
    self.imageLayer3.layer.zPosition = 0;
    self.imageLayer4.layer.zPosition = 0;
}

- (FBProfilePictureView *)getImageLayer
{
    FBProfilePictureView *mImageLayer = [[FBProfilePictureView alloc] init];
    mImageLayer.layer.borderWidth = self.borderWidth;
    mImageLayer.layer.borderColor = self.borderColor.CGColor;
    return mImageLayer;
}

- (UIImage *)imageFromText:(NSString *)text withCanvasSize:(CGSize)canvasSize andFontSize:(CGFloat)fontSize
{
    if (UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 0.0f;
        UIGraphicsBeginImageContextWithOptions(canvasSize, NO, imageScale);
    }
    else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    
    UIColor *color = [self randomColor];
    //UIColor *color = [UIColor colorWithRed:203 green:205 blue:207 alpha:1];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect rect = CGRectMake(0.0f, 0.0f, canvasSize.width, canvasSize.height);
    CGContextFillRect(context, rect);
    
    
    // draw in context, you can use also drawInRect:withFont:
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];//[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
    NSDictionary *attributesNew = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor whiteColor]};
    CGSize textSize = [text sizeWithAttributes:attributesNew];
    [text drawAtPoint:CGPointMake((canvasSize.width - textSize.width) / 2, (canvasSize.height - textSize.height) / 2) withAttributes:attributesNew];
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark -
#pragma mark - Accessors

- (FBProfilePictureView *)imageLayer1
{
    if (!_imageLayer1) {
        _imageLayer1 = [self getImageLayer];
        _imageLayer1.hidden = YES;
        [self addSubview:_imageLayer1];
    }
    return _imageLayer1;
}

- (FBProfilePictureView *)imageLayer2
{
    if (!_imageLayer2) {
        _imageLayer2 = [self getImageLayer];
        _imageLayer2.hidden = YES;
        [self addSubview:_imageLayer2];
    }
    return _imageLayer2;
}

- (FBProfilePictureView *)imageLayer3
{
    if (!_imageLayer3) {
        _imageLayer3 = [self getImageLayer];
        _imageLayer3.hidden = YES;
        [self addSubview:_imageLayer3];
    }
    return _imageLayer3;
}

- (FBProfilePictureView *)imageLayer4
{
    if (!_imageLayer4) {
        _imageLayer4 = [self getImageLayer];
        _imageLayer4.hidden = YES;
        [self addSubview:_imageLayer4];
    }
    return _imageLayer4;
}

- (UIImageView *)numberView
{
    if (!_numberView) {
        _numberView = [[UIImageView alloc] init];
        _numberView.layer.borderWidth = self.borderWidth;
        _numberView.layer.borderColor = self.borderColor.CGColor;
        _numberView.layer.masksToBounds = YES;
        _numberView.hidden = YES;
        [self addSubview:_numberView];
    }
    return _numberView;
}

@end
