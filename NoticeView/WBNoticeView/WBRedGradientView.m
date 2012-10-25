//
//  WBRedGradientView.m
//  GradientView
//
//  Created by Tito Ciuro on 6/3/12.
//  Copyright (c) 2012 Webbo, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "WBRedGradientView.h"

@implementation WBRedGradientView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        UIColor *redTop = [UIColor colorWithRed:167/255.0f green:26/255.0f blue:20/255.0f alpha:1.0];
        UIColor *redBot = [UIColor colorWithRed:134/255.0f green:9/255.0f blue:7/255.0f alpha:1.0];
        
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
        
        UIView *firstTopPinkLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, 1.0)];
        firstTopPinkLine.backgroundColor = [UIColor colorWithRed:211/255.0f green:82/255.0f blue:80/255.0f alpha:1.0];
        [self.backgroundView addSubview:firstTopPinkLine];
        
        UIView *secondTopRedLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, 1.0, self.bounds.size.width, 1.0)];
        secondTopRedLine.backgroundColor = [UIColor colorWithRed:193/255.0f green:30/255.0f blue:23/255.0f alpha:1.0];
        [self.backgroundView addSubview:secondTopRedLine];
        
        UIView *firstBotRedLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
        firstBotRedLine.backgroundColor = [UIColor colorWithRed:134/255.0f green:9/255.0f blue:7/255.0f alpha:1.0];
        [self.backgroundView addSubview:firstBotRedLine];
        
        UIView *secondBotDarkLine = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.bounds.size.height, self.frame.size.width, 1.0)];
        secondBotDarkLine.backgroundColor = [UIColor colorWithRed:52/255.0f green:4/255.0f blue:3/255.0f alpha:1.0];
        [self.backgroundView addSubview:secondBotDarkLine];
    }
    
    return self;
}

@end
