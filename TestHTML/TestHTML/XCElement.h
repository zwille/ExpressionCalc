//
//  XCElement.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCHasTriggers.h"
#import "XCHasHtmlOutput.h"
typedef struct {
    Byte focus : 1;
    Byte error : 1;
} XCElementState;

extern NSString * XC_HTML_FOCUS_FORMAT, * XC_HTML_ERROR_FORMAT;
@interface XCElement : NSObject<XCHasTriggers> {
    XCElement * _root;
    XCElementState _state;
}
@property (strong) XCElement * root;

-(id) initWithRoot: (XCElement*) root;
-(void) setFocus: (BOOL) val;
-(BOOL) hasFocus;
-(void) setError: (BOOL) val;
-(BOOL) hasError;
-(NSString*) toHTMLfromChild;
-(BOOL) isEmpty;
-(void) replaceWithElement: (XCElement*) element;


@end
