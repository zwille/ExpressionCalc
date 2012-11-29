//
//  XCViewController.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCElement.h"

@interface XCViewController : UIViewController {
    XCElement * _root;
    XCElement * _head;
}
@property (weak, nonatomic) IBOutlet UIWebView *textView;

- (IBAction)numkey:(id)sender;
- (IBAction)plus:(id)sender;
- (IBAction)mult:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)del:(id)sender;



@end
