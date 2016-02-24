//
// Created by David Clark on 24/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Button : UIButton

@property(nonatomic, strong) UIColor *color;
@property(nonatomic, strong) UIColor *highlightColor;
@property(nonatomic, strong) UIColor *blurColor;
@property(nonatomic) float blurScale;
@property(nonatomic) const float blurRadius;
@property(nonatomic) const float pulseDuration;
@end
