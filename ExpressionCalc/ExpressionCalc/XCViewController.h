//
//  XCViewController.h
//  ExpressionCalc
//
//  Created by Christoph Cwelich on 19.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *in;
@property (weak, nonatomic) IBOutlet UITextField *out;

- (IBAction)input:(id)sender;

@end
