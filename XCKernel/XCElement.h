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
    Byte sub1  : 1; 
    Byte sub2  : 1;
    Byte sub3  : 1;
    Byte subsub1  : 1;
    Byte subsub2  : 1;
    Byte subsub3  : 1;
} XCElementState;


@interface XCElement : NSObject<NSCopying, XCHasTriggers, XCHasHtmlOutput, XCEvaluable> {
    XCElement * _parent;
    @protected
    XCElementState _state;
}
@property (strong) XCElement * parent;

-(id) initWithParent: (XCElement*) parent;
-(void) setFocus: (BOOL) val;
-(BOOL) hasFocus;
-(void) setError: (BOOL) val;
-(BOOL) hasError;
-(NSString*) wrapHTML: (NSString*) inner;
-(BOOL) isEmpty;
-(void) normalize;
-(XCElement*) replaceContentWithElement: (XCElement*) element;
-(XCElement*) content;
-(XCElement*) head;
-(id<XCHasTriggers>) triggerNextContent;
-(id<XCHasTriggers>) triggerPreviousContent;
-(NSNumber*) checkErrorOn: (NSNumber*) num;

@end
