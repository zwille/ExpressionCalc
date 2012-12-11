//
//  XCViewController.m
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCViewController.h"
#import "XCGlobal.h"

@interface XCViewController ()

@end

@implementation XCViewController
@synthesize webView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _kernel = [[XCKernel alloc] init];
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSString * p = [mainBundle pathForResource:@"mathtemplate" ofType:@"html"];
    //NSLog(@"p=%@",p);
    _htmlTemplate = [NSString stringWithContentsOfFile:p encoding:NSStringEncodingConversionAllowLossy error:nil];
    //NSLog(@"s=%@",_htmlTemplate);
    [self updateHTMLExpression];
    _htmlOut = @"0";
    [self print];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) print {
    //[webView loadHTMLString: [_kernel toHTML] baseURL:nil];
    NSString * html = [NSString stringWithFormat:_htmlTemplate, _htmlExpression, _htmlOut];
    [webView loadHTMLString: html baseURL:nil];
}
- (void) updateHTMLExpression {
    _htmlExpression = [_kernel toHTML];
}

- (IBAction)braces:(id)sender {
    [_kernel triggerExpression];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)reset:(id)sender {
    [_kernel reset];
    [self updateHTMLExpression];
    [self print];
}
// operators
- (IBAction)plus:(id)sender {
    [_kernel triggerOperator:XC_OP_PLUS];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)minus:(id)sender {
    [_kernel triggerOperator:XC_OP_MINUS];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)mult:(id)sender {
    [_kernel triggerOperator:XC_OP_MULT];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)div:(id)sender {
    [_kernel triggerOperator:XC_OP_DIV];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)exp:(id)sender {
    [_kernel triggerOperator:XC_OP_EXP];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)num:(id)sender {
    NSUInteger tag = [sender tag];
    char c = (tag==10) ? XC_PT : tag+'0';
    [_kernel triggerNum:c];
    [self updateHTMLExpression];
    [self print];
}
- (IBAction)eval:(id)sender {
    NSNumber * res = [_kernel eval];
    _htmlOut = ([res isNaN]) ? @"ERROR" : [res description];
    [self print];
}

@end
