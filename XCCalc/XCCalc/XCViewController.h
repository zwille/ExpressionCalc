//
//  XCViewController.h
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCKernel.h"
@interface XCViewController : UIViewController {
    XCKernel * _kernel;
    NSString * _htmlTemplate;
    NSString * _htmlExpression;
    NSString * _htmlOut;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
