//
//  WBGradientView.h
//  Scout
//
//  Created by Levi Brown on 10/24/12.
//  Copyright (c) 2012 Valassis Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBGradientView : UIView

@property (nonatomic,weak) UIView *backgroundView;
@property (nonatomic,weak) CAGradientLayer *gradientLayer;

@end
