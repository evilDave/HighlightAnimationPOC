//
//  ViewController.m
//  HighlightAnimationPOC
//
//  Created by David Clark on 22/02/2016.
//  Copyright (c) 2016 David Clark. All rights reserved.
//


#import "ViewController.h"
#import "UIColor+HC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
	[self setView:[[UIView alloc] init]];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];

	UITextField *field1 = [[UITextField alloc] init];
	[field1 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[field1 setText:@"this is some control before the button"];
	[field1 setBorderStyle:UITextBorderStyleRoundedRect];
	[field1 setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:field1];
	[field1.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
	[field1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;

	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
	[button setTitle:@"Test" forState:UIControlStateNormal];
	[self.view addSubview:button];
	[button.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:100].active = YES;
	[button.heightAnchor constraintEqualToConstant:100].active = YES;
	[button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[button.widthAnchor constraintEqualToConstant:100].active = YES;

	UIView  *bg = [[UIView alloc] init];
	[bg setTranslatesAutoresizingMaskIntoConstraints:NO];
	[button addSubview:bg];
	[bg.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:100].active = YES;
	[bg.heightAnchor constraintEqualToConstant:100].active = YES;
	[bg.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[bg.widthAnchor constraintEqualToConstant:100].active = YES;

	UIView *fg = [[UIView alloc] init];
	[fg setTranslatesAutoresizingMaskIntoConstraints:NO];
	[fg setBackgroundColor:[UIColor HCBlueColor]];
	[fg.layer setCornerRadius:50];
	[button addSubview:fg];
	[fg.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:100].active = YES;
	[fg.heightAnchor constraintEqualToConstant:100].active = YES;
	[fg.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[fg.widthAnchor constraintEqualToConstant:100].active = YES;

	// capture button view contents
	CGSize size = CGSizeMake(103, 103);
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor HCBlueColor].CGColor);
	CGContextFillEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
	UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	// blur it
	CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[blurFilter setValue:[CIImage imageWithCGImage:circle.CGImage] forKey:@"inputImage"];
	[blurFilter setValue:@4.0f forKey:@"inputRadius"];
	CIImage *filterOutput = [blurFilter valueForKey:@"outputImage"];
	UIImage *blur = [[UIImage alloc] initWithCIImage:filterOutput];
	// insert it into the view stack
	UIImageView *imageView = [[UIImageView alloc] initWithImage:blur];
	[imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[bg addSubview:imageView];
	[imageView.centerYAnchor constraintEqualToAnchor:button.centerYAnchor].active = YES;
	[imageView.centerXAnchor constraintEqualToAnchor:button.centerXAnchor].active = YES;

	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[animation setDuration:0.6];
	[animation setRepeatCount:HUGE_VALF];
	[animation setAutoreverses:YES];
	[animation setFromValue:@(1)];
	[animation setToValue:@(0.1)];
	[imageView.layer addAnimation:animation forKey:@"animateOpacity"];

	UITextField *field2 = [[UITextField alloc] init];
	[field2 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[field2 setText:@"this is some control after the button"];
	[field2 setBorderStyle:UITextBorderStyleRoundedRect];
	[field2 setBackgroundColor:[UIColor whiteColor]];	[self.view addSubview:field2];
	[field2.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:50].active = YES;
	[field2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;

}

@end
