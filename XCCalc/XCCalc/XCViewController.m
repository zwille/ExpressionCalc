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

@synthesize portraitView;
@synthesize landscapeView;
@synthesize webViews;
@synthesize angleModeButton;
@synthesize numkeys;
@synthesize varButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    _kernel = [[XCKernel alloc] init];
    
    // load mathml templates 
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSString * path = [mainBundle pathForResource:@"basestyle" ofType:@"css"];
    NSString * baseStyle =
    [NSString stringWithContentsOfFile:path
                              encoding: NSStringEncodingConversionAllowLossy
                                 error:nil];
    path = [mainBundle pathForResource:@"templateLandscape" ofType:@"html"];
    _htmlTemplateLandscape =
    [NSString stringWithContentsOfFile:path
                              encoding: NSStringEncodingConversionAllowLossy
                                 error:nil];
    _htmlTemplateLandscape = [NSString stringWithFormat:_htmlTemplateLandscape,
                              baseStyle, @"%@", @"%@", @"%@"];
    path = [mainBundle pathForResource:@"templatePortrait" ofType:@"html"];
    _htmlTemplatePortrait =
    [NSString stringWithContentsOfFile:path
                              encoding: NSStringEncodingConversionAllowLossy
                                 error:nil];
    _htmlTemplatePortrait = [NSString stringWithFormat:_htmlTemplatePortrait,
                              baseStyle, @"%@", @"%@"];
    // set number format
    _sciformat = [[NSNumberFormatter alloc] init];
    [_sciformat setNumberStyle:NSNumberFormatterScientificStyle];
    [_sciformat setMaximumFractionDigits:10];
    [_sciformat setMaximumSignificantDigits:15];
    [_sciformat setExponentSymbol:@"x10^"];
    
    _decformat = [[NSNumberFormatter alloc] init];
    [_decformat setNumberStyle:NSNumberFormatterDecimalStyle];
    [_decformat setMaximumFractionDigits:10];
    [_decformat setMaximumSignificantDigits:15];
    
    [self reset:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"memory warning");
}

// update
- (void) updateNumKeys {
    NSString * format = @"%d";
    if (_numbersAsVariables || _storing) {
        format = @"X%d";
        [varButton setTitle:@"NUM" forState:UIControlStateNormal];
    } else {
        [varButton setTitle:@"VAR" forState:UIControlStateNormal];
    }
    for (UIButton * b in numkeys) {
        [b setTitle:[NSString stringWithFormat:format, [b tag]]
           forState: UIControlStateNormal];
    }
    
}

- (void) updateHTMLState {
    _htmlState = [NSString stringWithFormat:@"%@   %@   %@",
        ([_kernel isInExpression]) ? @"( )" : @"",
        ([_kernel isDegreeAngleMode]) ? @"DEG" : @"RAD",
        (_storing) ? @"STO" : (_numbersAsVariables) ? @"VAR" : @"NUM"
        ];
}
- (void) updateAngleModeButton {
    [angleModeButton setTitle:
     ([_kernel isDegreeAngleMode]) ? @"RAD" : @"DEG"
                     forState:UIControlStateNormal];
}

- (void) updateHTMLExpression {
    _htmlExpression = [_kernel toHTML];
}

- (void) print {
    NSString * html = nil;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        NSString * htmlResult = (_htmlOut) ?
        [NSString stringWithFormat:@" = %@",_htmlOut] : @"";
        html = [NSString stringWithFormat:_htmlTemplatePortrait, //format
                _htmlExpression, htmlResult]; //args
    } else {
        NSString * htmlResult = (_htmlOut) ?
        [NSString stringWithFormat:@" = %@",_htmlOut] : @"";
        html = [NSString stringWithFormat:_htmlTemplateLandscape, //format
                _htmlState,_htmlExpression, htmlResult]; //args
    }
    _htmlOut = nil;
     DLOG(@"XCVC::print html = %@",html);
    for (id webView in webViews) {
        [webView loadHTMLString: html baseURL:nil];
    }
}

//rotate
-(void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation) orientation
                                        duration:
(NSTimeInterval)duration {
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            [self setView:portraitView];
            [[self view] setTransform:CGAffineTransformIdentity];
            [[self view] setTransform:CGAffineTransformMakeRotation(0)];
            [[self view] setBounds:CGRectMake(0, 0, 320, 548)];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self setView:landscapeView];
            [[self view] setTransform:CGAffineTransformIdentity];
            [[self view] setTransform:CGAffineTransformMakeRotation(-M_PI/2)];
            [[self view] setBounds:CGRectMake(0, 0, 568, 300)];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self setView:landscapeView];
            [[self view] setTransform:CGAffineTransformIdentity];
            [[self view] setTransform:CGAffineTransformMakeRotation(M_PI/2)];
            [[self view] setBounds:CGRectMake(0, 0, 568, 300)];
            break;
            
        default:
            //pass
            break;
    }
    [self print];
}

// actions
// control
- (IBAction)del:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerDel];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}

- (IBAction)ans:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerVariable:XC_ANS_IDX];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)store:(id)sender {
    _storing = !_storing;
    [self updateNumKeys];
    [self updateHTMLState];
    [self print];
}

- (IBAction)eval:(id)sender {
    if (_storing) {
        return;
    }
    NSNumber * result = [_kernel eval];
    if([result isInteger]) {
        _htmlOut = [_decformat stringFromNumber:result];
    } else { // result is double
        if ([result isNaN]) {
            _htmlOut = @"ERROR";
        } else {
            double absval = fabs([result doubleValue]);
            if (absval > 1e10 || absval < 1e-10) {
                _htmlOut = [_sciformat stringFromNumber:result];
            } else {
                _htmlOut = [_decformat stringFromNumber:result];
            }
        }
    }
    [self updateHTMLExpression];
    [self updateHTMLState];
    [self print];
}

- (IBAction)reset:(id)sender {
    _storing = NO;
    _numbersAsVariables = NO;
    [_kernel reset];
    [self updateNumKeys];
    [self updateAngleModeButton];
    [self updateHTMLState];
    [self updateHTMLExpression];
    _htmlOut = nil;
    [self print];
}

- (IBAction)changeAngleMode:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel toggleAngleMode];
    [self updateAngleModeButton];
    [self updateHTMLState];
    [self print];
    
}

- (IBAction)var:(id)sender {
    if (_storing) {
        return;
    }
    _numbersAsVariables = !_numbersAsVariables;
    [self updateNumKeys];
    [self updateHTMLState];
    [self print];
}

// navigation
- (IBAction)up:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel previousStatement];
    _htmlOut = nil;
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
    
}
- (IBAction)down:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel nextStatement];
    _htmlOut = nil;
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)right:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerNext];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)left:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerPrevious];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)enter:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerEnter];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}

// literals functions
- (IBAction)euler:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerConstant:XC_EULER_ID];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)pi:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerConstant:XC_PI_ID];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)function:(id)sender {
    if (_storing) {
        return;
    }
    NSString * fname = [sender currentTitle];
    assert(fname);
    [_kernel triggerFunction:fname];
    [self updateHTMLExpression];
    [self print];
}

- (IBAction)num:(id)sender {
    NSUInteger tag = [sender tag];
    if (_storing) {
        if (tag==10) {
            return;
        }
        [_kernel assignToVar:tag];
        _storing = NO;
        [self updateNumKeys];
        [self updateHTMLState];
    } else if(_numbersAsVariables) {
        if (tag==10) {
            return;
        }
        [_kernel triggerVariable:tag];
    } else {
        char c = (tag==10) ? XC_PT : tag+'0';
        [_kernel triggerNum:c];
    }
    [self updateHTMLExpression];
    [self print];
}

// operators
- (IBAction)plus:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerOperator:XC_OP_PLUS];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)minus:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerOperator:XC_OP_MINUS];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)mult:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerOperator:XC_OP_MULT];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)div:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerOperator:XC_OP_DIV];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}
- (IBAction)exp:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerOperator:XC_OP_EXP];
    [self updateHTMLExpression];
     [self updateHTMLState];
    [self print];
}

- (IBAction)braces:(id)sender {
    if (_storing) {
        return;
    }
    [_kernel triggerExpression];
    [self updateHTMLExpression];
    [self updateHTMLState];
    [self print];
}

@end
