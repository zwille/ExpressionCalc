//
//  XCElement.h
//  XCCalc
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
    // for subclasses level 1 (XCTupleElement...)
    Byte sub1  : 1; 
    Byte sub2  : 1;
    Byte sub3  : 1;
    // for subclasses level 0
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
//wrap html with state spans
-(NSString*) wrapHTML: (NSString*) inner;
-(BOOL) isEmpty;
-(void) normalize;
//replace the (current) content with the given element
-(XCElement*) replaceContentWithElement: (XCElement*) element;
// the (current) content
-(XCElement*) content;
-(XCElement*) head;
// if has more than single content, else triggerNext
-(id<XCHasTriggers>) triggerNextContent;
// if has more than single content, else triggerPrevious
-(id<XCHasTriggers>) triggerPreviousContent;
// checks if num is errorneous, if YES set self state.error to YES
-(NSNumber*) checkErrorOn: (NSNumber*) num;

@end
