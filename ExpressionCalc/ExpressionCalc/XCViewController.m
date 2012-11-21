//
//  XCViewController.m
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCViewController.h"
#import "XCTokenizer.h"
#import "XCStringIterator.h"
#import "XCToken.h"

@interface XCViewController ()

@end

@implementation XCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)input:(id)sender {
    id<XCCharIterator> it = [[XCStringIterator alloc] initWithString: [sender text]];
    XCTokenizer * tok = [[XCTokenizer alloc] initWithStatement: it];
    
    while (true) {
        id token = [tok nextToken];
        NSLog(@"%@",token);
        XCTokenType t = [token tokenType];
        if(t==END_OF_STATEMENT) {
            break;
        }
    }
    [sender setText:@""];
}
@end
