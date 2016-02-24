//
// Created by David Clark on 24/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import "Button.h"

@implementation Button {
	UIView *_fg;
	UIImageView *_imageView;
	UIColor *_currentColor;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
	Button *button = [super buttonWithType:buttonType];
	[button postButtonWithTypeInit];
	return button;
}

- (void)postButtonWithTypeInit {
	UIView *bg = [[UIView alloc] init];
	[bg setUserInteractionEnabled:NO];
	[bg setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self addSubview:bg];
	[bg.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
	[bg.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
	[bg.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
	[bg.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;

	// insert blur into the view stack
	_imageView = [[UIImageView alloc] init];
	[_imageView setUserInteractionEnabled:NO];
	[_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[bg addSubview:_imageView];
	[_imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
	[_imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;

	_fg = [[UIView alloc] init];
	[_fg setUserInteractionEnabled:NO];
	[_fg setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self addSubview:_fg];
	[_fg.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
	[_fg.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
	[_fg.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
	[_fg.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;

}

- (UIImage *)getBlurImage {
	// create a background to blur, a little larger than the size of the button
	CGFloat buttonBlurSize = floorf(self.frame.size.width * self.blurScale);
	CGSize size = CGSizeMake(buttonBlurSize, buttonBlurSize);
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, self.blurColor.CGColor);
	CGContextFillEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
	UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	// blur it
	CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[blurFilter setValue:[CIImage imageWithCGImage:circle.CGImage] forKey:@"inputImage"];
	[blurFilter setValue:@(self.blurRadius) forKey:@"inputRadius"];
	CIImage *filterOutput = [blurFilter valueForKey:@"outputImage"];
	UIImage *blur = [[UIImage alloc] initWithCIImage:filterOutput];
	return blur;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	[_fg.layer setCornerRadius:self.frame.size.width/2]; // could do this with CGContextFillEllipseInRect if this does not work well enough
	[_fg setBackgroundColor:_currentColor ?: self.color];

	UIImage *blur = [self getBlurImage]; // TODO: only do all this if the size is changed, i.e. cache it
	[_imageView setImage:blur];
	// animate it
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[animation setDuration:self.pulseDuration];
	[animation setRepeatCount:HUGE_VALF];
	[animation setAutoreverses:YES];
	[animation setFromValue:@(1)];
	[animation setToValue:@(0)];
	[_imageView.layer addAnimation:animation forKey:@"animateOpacity"];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	_currentColor = highlighted ? self.highlightColor : self.color;
	[_imageView setHidden:highlighted];
}

@end
