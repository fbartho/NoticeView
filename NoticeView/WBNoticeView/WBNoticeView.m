//
//  WBNoticeView.m
//  NoticeView
//
//  Heavily modified by Levi Brown on Oct 4, 2012
//
//  Created by Tito Ciuro on 5/16/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "WBNoticeView.h"
#import "WBRedGradientView.h"
#import "WBBlueGradientView.h"
#import "WBGrayGradientView.h"
#import "UILabel+WBExtensions.h"

#import <QuartzCore/QuartzCore.h>

@interface WBNoticeView ()

@property (nonatomic,strong) UIView *gradientView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic,assign) CGFloat hiddenYOrigin;
@property (nonatomic,copy) NSString *noticeIconImageName;
@property (nonatomic,assign) Class gradientViewClass;

+ (void)_raiseIfObjectIsNil:(id)object named:(NSString *)name;

@end

@implementation WBNoticeView

#pragma mark - Creators

+ (WBNoticeView *)noticeOfType:(WBNoticeType)noticeType
                        inView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(NSTimeInterval)duration
                dismissedBlock:(WBNoticeViewDismissedBlock)dismissedBlock
{
    return [self noticeOfType:noticeType inView:view title:title message:message duration:duration delay:0.0f alpha:0.0f originY:0.0f dismissedBlock:dismissedBlock];
}

+ (WBNoticeView *)noticeOfType:(WBNoticeType)noticeType
                    inView:(UIView *)view
                   title:(NSString *)title
                 message:(NSString *)message
                duration:(NSTimeInterval)duration
                   delay:(NSTimeInterval)delay
                   alpha:(CGFloat)alpha
                 originY:(CGFloat)originY
                dismissedBlock:(WBNoticeViewDismissedBlock)dismissedBlock
{
    WBNoticeView *retVal = [[WBNoticeView alloc] initWithView:view];
    
    retVal.title = title;
    retVal.message = message;
    retVal.duration = duration;
    retVal.delay = delay;
    retVal.alpha = alpha;
    retVal.originY = originY;
    retVal.dismissedBlock = dismissedBlock;

    switch (noticeType) {
        case WBNoticeTypeError:
            retVal.sticky = NO;
            retVal.noticeIconImageName = @"notice_error_icon.png";
            retVal.gradientViewClass = WBRedGradientView.class;
            break;
        case WBNoticeTypeSuccess:
            retVal.sticky = NO;
            retVal.noticeIconImageName = @"notice_success_icon.png";
            retVal.gradientViewClass = WBBlueGradientView.class;
            break;
        case WBNoticeTypeSticky:
            retVal.sticky = YES;
            retVal.noticeIconImageName = @"up.png";
            retVal.gradientViewClass = WBGrayGradientView.class;
            break;
    }

    return retVal;
}

#pragma mark - Lifecycle

- (void)cleanup
{
    [self.gradientView removeFromSuperview];
    self.gradientView = nil;
    self.titleLabel = nil;
    self.messageLabel = nil;
    [self removeNotice:self];
}

- (void)dealloc
{
    [self cleanup];
}

- (id)initWithView:(UIView *)theView
{
    [WBNoticeView _raiseIfObjectIsNil:theView named:@"view"];
    
    if ((self = [super init]))
    {
        self.view = theView;
    }
    
    return self;
}

#pragma mark - Implementation

- (void)show
{
    if (!self.gradientView)
    {
        // Set default values if needed
        NSString *title = self.title ?: @"";
        NSString *message = self.message ?: @"";
        NSTimeInterval duration = self.duration == 0.0f ? 0.5 : self.duration;
        CGFloat alpha = self.alpha == 0.0f ? 0.8 : self.alpha;
        CGFloat originY = self.originY < 0.0f ? 0.0 : self.originY;
        NSTimeInterval delay = self.sticky ? 0.0f : self.delay == 0.0f ? 2.0f : self.delay;

        // Obtain the screen width
        CGFloat viewWidth = self.view.frame.size.width;
        
        // Locate the images
        NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
        NSString *noticeIconImageName = [path stringByAppendingPathComponent:self.noticeIconImageName];
        
        // Make and add the title label
        float titleYOrigin = 10.0;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = title;
        
        // Make the message label
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, 20.0 + 10.0, viewWidth - 70.0, 12.0)];
        self.messageLabel.font = [UIFont systemFontOfSize:13.0];
        self.messageLabel.textColor = [UIColor colorWithRed:239.0/255.0 green:167.0/255.0 blue:163.0/255.0 alpha:1.0];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.text = message;
        
        // Calculate the number of lines it'll take to display the text
        NSInteger numberOfLines = [[self.messageLabel lines]count];
        self.messageLabel.numberOfLines = numberOfLines;
        [self.messageLabel sizeToFit];
        CGFloat messageLabelHeight = self.messageLabel.frame.size.height;
        
        CGRect r = self.messageLabel.frame;
        r.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
        
        float noticeViewHeight = 0.0;
        double currOsVersion = [[[UIDevice currentDevice]systemVersion]doubleValue];
        if (currOsVersion >= 6.0f) {
            noticeViewHeight = messageLabelHeight;
        } else {
            // Now we can determine the height of one line of text
            r.size.height = self.messageLabel.frame.size.height * numberOfLines;
            r.size.width = viewWidth - 70.0;
            self.messageLabel.frame = r;
            
            // Calculate the notice view height
            noticeViewHeight = 10.0;
            if (numberOfLines > 1) {
                noticeViewHeight += ((numberOfLines - 1) * messageLabelHeight);
            }
        }
        
        // Add some bottom margin for the notice view
        noticeViewHeight += 30.0;
        
        // Make sure we hide completely the view, including its shadow
        float hiddenYOrigin = -noticeViewHeight - 20.0;
        
        // Make and add the notice view
        self.gradientView = [[self.gradientViewClass alloc]initWithFrame:CGRectMake(0.0, hiddenYOrigin, viewWidth, noticeViewHeight + 10.0)];
        [self.view addSubview:self.gradientView];
        
        // Make and add the icon view
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
        iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconView.alpha = 0.8;
        [self.gradientView addSubview:iconView];
        
        // Add the title label
        [self.gradientView addSubview:self.titleLabel];
        
        // Add the message label
        [self.gradientView addSubview:self.messageLabel];
        
        // Add the drop shadow to the notice view
        CALayer *noticeLayer = self.gradientView.layer;
        noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
        noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
        noticeLayer.shadowOpacity = 0.50;
        noticeLayer.masksToBounds = NO;
        noticeLayer.shouldRasterize = YES;
        
        self.duration = duration;
        self.delay = delay;
        self.alpha = alpha;
        self.hiddenYOrigin = hiddenYOrigin;
        
        [self displayNoticeWithDuration:duration delay:delay originY:originY hiddenYOrigin:hiddenYOrigin alpha:alpha];
    }
}

- (void)dismiss
{
    [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin userInitiated:NO];
}

#pragma mark - Internals

static NSMutableSet *_notices = nil;

- (void)addNotice:(WBNoticeView *)currentNotice
{
    if (!_notices)
    {
        _notices = [NSMutableSet set];
    }
    [_notices addObject:currentNotice];
}

- (void)removeNotice:(WBNoticeView *)currentNotice
{
    [_notices removeObject:currentNotice];
    if (_notices.count == 0)
    {
        _notices = nil;
    }
}

- (void)displayNoticeWithDuration:(CGFloat)duration delay:(CGFloat)delay originY:(CGFloat)originY hiddenYOrigin:(CGFloat)hiddenYOrigin alpha:(CGFloat)alpha
{
    // If the notice is sticky, add tap capabilities
    if (self.sticky) {
        [self addNotice:self];
        // Add an invisible button that responds to a manual dismiss
        CGRect frame = self.gradientView.frame;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        frame.origin.x = frame.origin.y = 0.0;
        button.frame = frame;
        [button addTarget:self action:@selector(dismissNotice) forControlEvents:UIControlEventTouchUpInside];
        [self.gradientView addSubview:button];
    }
    
    // Go ahead, display it
    [UIView animateWithDuration:duration animations:^ {
        CGRect newFrame = self.gradientView.frame;
        newFrame.origin.y = originY;
        self.gradientView.frame = newFrame;
        self.gradientView.alpha = alpha;
    } completion:^ (BOOL finished) {
        // if it's not sticky, hide it automatically
        if (NO == self.sticky) {
            // Display for a while, then hide it again
            [self dismissNoticeWithDuration:duration delay:delay hiddenYOrigin:hiddenYOrigin userInitiated:NO];
        }
    }];
}

- (void)dismissNoticeWithDuration:(CGFloat)duration delay:(CGFloat)delay hiddenYOrigin:(CGFloat)hiddenYOrigin userInitiated:(BOOL)userInitiated
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^ {
        CGRect newFrame = self.gradientView.frame;
        newFrame.origin.y = hiddenYOrigin;
        self.gradientView.frame = newFrame;
    } completion:^ (BOOL finished) {
        if (self.dismissedBlock)
        {
            self.dismissedBlock(userInitiated);
        }
        // Cleanup
        [self cleanup];
    }];
}

- (void)dismissNotice
{
    [self dismissNoticeWithDuration:self.duration delay:self.delay hiddenYOrigin:self.hiddenYOrigin userInitiated:YES];
}

+ (void)_raiseIfObjectIsNil:(id)object named:(NSString *)name
{
    if (nil == object) {
        // If the name has not been supplied, name it generically
        if (nil == name) name = @"<name not supplied>";
        
        // Log the stack trace
        NSLog(@"%@", [NSThread callStackSymbols]);
        
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"*** -[%@ %@]: '%@' cannot be nil.", [self class], NSStringFromSelector(_cmd), name]
                               userInfo:nil]raise];
    }
}

@end
