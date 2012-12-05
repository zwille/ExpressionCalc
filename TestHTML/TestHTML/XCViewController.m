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
    _kernel = [[XCKernel alloc] init];
    [self print];
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
    NSLog(@"VC::numkey %c",c);
    [_kernel triggerNum:c];
    [self print];
}

- (IBAction)plus:(id)sender {
    NSLog(@"VC::plus");
    [_kernel triggerOperator:XC_OP_PLUS];
    [self print];
}
-(void)minus:(id)sender {
    NSLog(@"VC::minus");
    [_kernel triggerOperator:XC_OP_MINUS];
    [self print];
}

- (IBAction)mult:(id)sender {
    NSLog(@"VC::mult");
    [_kernel triggerOperator:XC_OP_MULT];
    [self print];
}

- (IBAction)div:(id)sender {
    NSLog(@"VC::div");
    [_kernel triggerOperator:XC_OP_DIV];
    [self print];
}

- (IBAction)expo:(id)sender {
    NSLog(@"VC::expo");
    [_kernel triggerOperator:XC_OP_EXP];
    [self print];

}

- (IBAction)expr:(id)sender {
    NSLog(@"VC::expo");
    [_kernel triggerExpression];
    [self print];
}

- (IBAction)reset:(id)sender {
    NSLog(@"VC::reset");
    [_kernel reset];
    [self print];
}

- (IBAction)del:(id)sender {
    NSLog(@"VC::del");
    [_kernel triggerDel];
    [self print];

}

- (IBAction)left:(id)sender {
     NSLog(@"VC::left");
    [_kernel triggerPrevious];
   
    [self print];
}

- (IBAction)enter:(id)sender {
    NSLog(@"VC::enter");
    [_kernel triggerEnter];
    
    [self print];

}

- (IBAction)right:(id)sender {
    NSLog(@"VC::right");
    [_kernel triggerNext];
    
    [self print];

}

- (void) print {
    [textView loadHTMLString: [_kernel toHTML] baseURL:nil];
}
@end
