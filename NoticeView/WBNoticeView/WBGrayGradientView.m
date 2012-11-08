//
//  WBGrayGradientView.m
//  NoticeView
//
//  Heavily modified by Levi Brown on Oct 4, 2012
//
//  Created by Tito Ciuro on 6/3/12.
//  Copyright (c) 2012 Webbo, LLC. All rights reserved.
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

#import <QuartzCore/QuartzCore.h>

#import "WBGrayGradientView.h"

@implementation WBGrayGradientView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        UIColor *redTop = [UIColor colorWithRed:198/255.0f green:200/255.0f blue:202/255.0f alpha:1.0];
        UIColor *redBot = [UIColor colorWithRed:225/255.0f green:228/255.0f blue:229/255.0f alpha:1.0];
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.contentsScale = [[UIScreen mainScreen] scale];
        self.gradientLayer.frame = self.bounds;
        self.gradientLayer.colors = [NSArray arrayWithObjects:
                           (id)redTop.CGColor,
                           (id)redBot.CGColor,
                           nil];
        self.gradientLayer.locations = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:0.7],
                              nil];
        
        [self.backgroundView.layer insertSublayer:self.gradientLayer atIndex:0];
        
        UIView *firstBotWhiteLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
        firstBotWhiteLine.backgroundColor = [UIColor colorWithRed:236/255.0f green:238/255.0f blue:239/255.0f alpha:1.0];
        [self.backgroundView addSubview:firstBotWhiteLine];
        
        UIView *secondBotDarkLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height, self.frame.size.width, 1.0)];
        secondBotDarkLine.backgroundColor = [UIColor colorWithRed:113/255.0f green:114/255.0f blue:115/255.0f alpha:1.0];
        [self.backgroundView addSubview:secondBotDarkLine];
    }

    return self;
}

@end
