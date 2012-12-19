//
//  XCComplexElementContent.h
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCElement.h"

@interface XCComplexElementContent : NSObject<NSFastEnumeration> {
    NSMutableArray * _operands;
    NSUInteger _idx;
}
@property (readonly) NSUInteger index;
-(id)copyWithZone: (NSZone*) zone
          andRoot: (XCElement*) root;

-(NSUInteger) length;
-(bool) isEmpty;
-(bool) hasNext;
-(bool) hasPrevious;
-(XCElement*) currentElement;
-(XCElement*) elementAtIndex: (NSUInteger) index;
-(NSUInteger) nextIndex;
-(NSUInteger) previousIndex;
-(void) insertElement: (XCElement*) element;
-(void) insert: (XCComplexElementContent*) elements;
-(void) removeCurrent;
-(void) replaceCurrentWith: (XCElement*) element;

@end
