//
//  XCViewController.h
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCKernel.h"
typedef enum {XC_VC_NORMAL, XC_VC_VAR_IDX} XCVCInputState;
@interface XCViewController : UIViewController {
    XCKernel * _kernel;
    XCVCInputState inputState;
    NSString * _htmlTemplatePortrait;
    NSString * _htmlTemplateLandscape;
    NSString * _htmlState;
    NSString * _htmlExpression;
    NSString * _htmlOut;
    NSNumberFormatter * _decformat, * _sciformat;
}
@property (strong, nonatomic) IBOutlet UIView *portraitView;
@property (strong, nonatomic) IBOutlet UIView *landscapeView;
@property (strong, nonatomic) IBOutletCollection(UIWebView) NSArray *webViews;
@property (weak, nonatomic) IBOutlet UIButton *angleModeButton;

// control
- (IBAction)del:(id)sender;
- (IBAction)ans:(id)sender;
- (IBAction)recall:(id)sender; //TODO
- (IBAction)store:(id)sender; //TODO
- (IBAction)eval:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)changeAngleMode:(id)sender;

// navigation
- (IBAction)up:(id)sender;
- (IBAction)down:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)right:(id)sender;
- (IBAction)enter:(id)sender;

// literals
- (IBAction)euler:(id)sender;
- (IBAction)pi:(id)sender;
- (IBAction)function:(id)sender;
- (IBAction)num:(id)sender;

// operators
- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;
- (IBAction)mult:(id)sender;
- (IBAction)div:(id)sender;
- (IBAction)exp:(id)sender;
- (IBAction)braces:(id)sender;

@end
