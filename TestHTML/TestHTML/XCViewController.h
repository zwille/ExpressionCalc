//
//  XCViewController.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCElement.h"
#import "XCKernel.h"
@interface XCViewController : UIViewController {
    XCKernel * _kernel;
}
@property (weak, nonatomic) IBOutlet UIWebView *textView;

- (IBAction)numkey:(id)sender;
- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)del:(id)sender;



@end
