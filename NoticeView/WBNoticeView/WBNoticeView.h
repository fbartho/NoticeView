//
//  WBNoticeView.h
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

#import <Foundation/Foundation.h>

@interface WBNoticeView : NSObject

typedef enum {
    WBNoticeTypeError = 0,
    WBNoticeTypeSuccess,
    WBNoticeTypeSticky
} WBNoticeType;

typedef void (^WBNoticeViewDismissedBlock)(BOOL userDismissed);

@property (nonatomic) WBNoticeType noticeType;

@property (nonatomic,strong) UIView *view;
@property (nonatomic,copy) NSString *title; // default: @""
@property (nonatomic,copy) NSString *message; // default: @""
@property (nonatomic,strong) UIImage *iconImage;

@property (nonatomic,assign) CGFloat duration; // default: 0.5
@property (nonatomic,assign) CGFloat delay; // default: 2.0
@property (nonatomic,assign) CGFloat alpha; // default: 1.0
@property (nonatomic,assign) CGFloat originY; // default: 0.0
@property (nonatomic,assign) BOOL sticky; // default NO (Error and Success notice); YES (Sticky notice)
@property (nonatomic,strong) UIColor *messageColor;
@property (nonatomic,copy) WBNoticeViewDismissedBlock dismissedBlock;


// throws NSInvalidArgumentException is view is nil.
+ (WBNoticeView *)noticeOfType:(WBNoticeType)noticeType
                        inView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(NSTimeInterval)duration
                dismissedBlock:(WBNoticeViewDismissedBlock)dismissedBlock;

// throws NSInvalidArgumentException is view is nil.
+ (WBNoticeView *)noticeOfType:(WBNoticeType)noticeType
                        inView:(UIView *)view
                         title:(NSString *)title
                       message:(NSString *)message
                      duration:(NSTimeInterval)duration
                         alpha:(CGFloat)alpha
                       originY:(CGFloat)originY
                dismissedBlock:(WBNoticeViewDismissedBlock)dismissedBlock;

- (void)show;
- (void)dismiss;

@end
