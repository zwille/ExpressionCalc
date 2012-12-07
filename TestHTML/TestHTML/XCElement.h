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
#import "XCEvaluable.h"

typedef struct {
    Byte focus : 1;
    Byte error : 1;
    Byte hasDecimalPt : 1; //used by XCNumString
} XCElementState;


@interface XCElement : NSObject<XCHasTriggers, XCHasHtmlOutput, XCEvaluable> {
    XCElement * _root;
    @protected
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
-(XCElement*) replaceContentWithElement: (XCElement*) element;
-(XCElement*) content;
-(XCElement*) head;

@end
