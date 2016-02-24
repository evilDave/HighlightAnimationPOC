//
//  ViewController.m
//  HighlightAnimationPOC
//
//  Created by David Clark on 22/02/2016.
//  Copyright (c) 2016 David Clark. All rights reserved.
//


#import "ViewController.h"
#import "UIColor+HC.h"
#import "Button.h"


@interface ViewController ()

@end

static const int controlSpacing = 20;
static const int buttonSize = 100;
static const float buttonBlurScale = 1.08;
static const float buttonBlurRadius = 2.2;
static const float buttonPulseDuration = 0.8;

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
	[field1.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:controlSpacing].active = YES;
	[field1.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:controlSpacing].active = YES;

	Button *button = [Button buttonWithType:UIButtonTypeCustom];
	[button setTranslatesAutoresizingMaskIntoConstraints:NO];
	[button setTitle:@"Test" forState:UIControlStateNormal];
	[button setColor:[UIColor HCBlueColor]];
	[button setHighlightColor:[UIColor HCDarkBlueColor]];
	[button setBlurColor:[UIColor HCGlowColor]];
	[button setBlurScale:buttonBlurScale];
	[button setBlurRadius:buttonBlurRadius];
	[button setPulseDuration:buttonPulseDuration];
	[self.view addSubview:button];
	[button.topAnchor constraintEqualToAnchor:field1.bottomAnchor constant:controlSpacing].active = YES;
	[button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[button.heightAnchor constraintEqualToConstant:buttonSize].active = YES;
	[button.widthAnchor constraintEqualToConstant:buttonSize].active = YES;

	UITextField *field2 = [[UITextField alloc] init];
	[field2 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[field2 setText:@"this is some control after the button"];
	[field2 setBorderStyle:UITextBorderStyleRoundedRect];
	[field2 setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:field2];
	[field2.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:controlSpacing].active = YES;
	[field2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:controlSpacing].active = YES;

	UITextField *field3 = [[UITextField alloc] init];
	[field3 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[field3 setText:@"this is another control"];
	[field3 setBorderStyle:UITextBorderStyleRoundedRect];
	[field3 setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:field3];
	[field3.topAnchor constraintEqualToAnchor:field2.bottomAnchor constant:controlSpacing].active = YES;
	[field3.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:controlSpacing].active = YES;

	UITextField *field4 = [[UITextField alloc] init];
	[field4 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[field4 setText:@"this is the last control"];
	[field4 setBorderStyle:UITextBorderStyleRoundedRect];
	[field4 setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:field4];
	[field4.topAnchor constraintEqualToAnchor:field3.bottomAnchor constant:controlSpacing].active = YES;
	[field4.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:controlSpacing].active = YES;

	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button2 setTranslatesAutoresizingMaskIntoConstraints:NO];
	[button2 setTitle:@"Test" forState:UIControlStateNormal];
	[self.view addSubview:button2];
	[button2.topAnchor constraintEqualToAnchor:field4.bottomAnchor constant:controlSpacing].active = YES;
	[button2.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	[button2.heightAnchor constraintEqualToConstant:buttonSize].active = YES;
	[button2.widthAnchor constraintEqualToConstant:buttonSize].active = YES;

}

@end
