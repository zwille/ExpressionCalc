//
//  XCViewController.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCViewController.h"
#import "XCExpr.h"

@interface XCViewController ()

@end

@implementation XCViewController
@synthesize textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    kernel = [[XCKernel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numkey:(id)sender {
    NSUInteger tag = [sender tag];
    char c = tag + '0';
    if (tag==10) {
        c = '.';
    } else if(tag==11) {
        c = 'E';
    }
    [_kernel triggerNum:c];
    [self print];
}

- (IBAction)plus:(id)sender {
    [_kernel triggerOperator:XC_OP_PLUS];
    [self print];
}
-(void)minus:(id)sender {
    [_kernel triggerOperator:XC_OP_MINUS];
    [self print];
}

- (IBAction)mult:(id)sender {
    [_kernel triggerOperator:XC_OP_MULT];
    [self print];
}

- (IBAction)reset:(id)sender {
    [_kernel reset];
    [self print];
}

- (IBAction)del:(id)sender {
    [_kernel triggerDel];
    [self print];

}

- (void) print {
    [textView loadHTMLString: [_kernel toHTML] baseURL:nil];
}
@end
