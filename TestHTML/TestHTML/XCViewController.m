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
    [self reset:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numkey:(id)sender {
    _head = [_head triggerNum:[sender tag]+'0'];
    NSLog(@"numkey tag: %d",[sender tag]);
    [self print];
}

- (IBAction)plus:(id)sender {
    _head = [_head triggerPlus];
    NSLog(@"plus");
    [self print];
}

- (IBAction)mult:(id)sender {
    _head = [_head triggerMult];
    NSLog(@"mult");
    [self print];
}

- (IBAction)reset:(id)sender {
    _head = [XCExpr emptyExpression];
    _root = _head;
    [self print];
}

- (IBAction)del:(id)sender {
    _head = [_head triggerDel];
    NSLog(@"mult");
    [self print];

}

- (void) print {
    NSString * headDesc = [NSString stringWithFormat:@"head: %@ %@",_head,([_head waitingForLiteral]) ? @"WFL" : @""];
    NSString * rootDesc = [NSString stringWithFormat:@"root: %@ %@",_root,([_root waitingForLiteral]) ? @"WFL" : @""];
    NSLog(@"%@",headDesc);
    NSLog(@"%@",rootDesc);
    [textView loadHTMLString: [_root toHTML] baseURL:nil];
  
}
@end
