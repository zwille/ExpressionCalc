//
//  XCComplexElement.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"

@interface XCComplexElement : XCElement {
    NSMutableArray * _operands;
    NSUInteger _idx;
    @protected
    bool _waitingForLiteral;
}
@property (strong,readonly) NSArray * operands;
-(void)setCurrentWithElement: (XCElement*) e;
-(void)shiftRight;
-(XCElement*) currentElement;
-(NSString*) htmlFromElement: (XCElement*) e isFirstElement: (bool) isFirst;
-(NSString*) htmlLastOp;

@end
