//
//  XCKernel.h
//  XCCalc
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCHasTriggers.h"
#import "XCEvaluable.h"
#import "XCElement.h"
#import "XCStatementBuffer.h"

@interface XCKernel : NSObject<XCHasTriggers, XCHasHtmlOutput, XCEvaluable> {
    XCStatement * _root;
    XCElement * _head;
    XCStatementBuffer * _statements;
    
}
@property (strong, readonly) XCStatement * root;
-(void) reset;
-(void) nextStatement;
-(void) previousStatement;
-(void) toggleAngleMode;
-(BOOL) isDegreeAngleMode;
-(BOOL) isInExpression;
-(void) assignToVar: (NSUInteger) varIdx;
@end
