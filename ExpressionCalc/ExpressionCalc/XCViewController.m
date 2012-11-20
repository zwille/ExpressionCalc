//
//  XCViewController.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCViewController.h"
#import "XCTokenizer.h"

@interface XCViewController ()

@end

@implementation XCViewController
@synthesize tfE;
@synthesize tfExp;
@synthesize tfPi;
@synthesize tfSqrt;
- (void)viewDidLoad
{
    [super viewDidLoad];
    unichar tmp = EULER;
	[tfE setText:[[NSString alloc] initWithCharacters: &tmp length:1]];
    tmp = SQRT;
    [tfSqrt setText:[[NSString alloc] initWithCharacters: &tmp length:1]];
    tmp = '^';
    [tfExp setText:[[NSString alloc] initWithCharacters: &tmp length:1]];
    tmp = PI;
    [tfPi setText:[[NSString alloc] initWithCharacters: &tmp length:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
