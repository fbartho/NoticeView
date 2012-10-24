//
//  WBGradientView.m
//  Scout
//
//  Created by Levi Brown on 10/24/12.
//  Copyright (c) 2012 Valassis Communications, Inc. All rights reserved.
//

#import "WBGradientView.h"

@implementation WBGradientView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *background = [[UIView alloc] initWithFrame:self.bounds];
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:background];
        self.backgroundView = background;
    }
    
    return self;
}

- (void)setAlpha:(CGFloat)alpha
{
    self.backgroundView.alpha = alpha;
}

- (CGFloat)alpha
{
    return self.backgroundView.alpha;
}

@end
