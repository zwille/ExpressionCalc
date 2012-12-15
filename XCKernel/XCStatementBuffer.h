//
//  XCStatementBuffer.h
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCStatement.h"
#import "XCCircBuf.h"


@interface XCStatementBuffer : NSObject {
    XCCircBuf * _buf;
    NSUInteger _idx;
    XCElement * _head;
}

-(void) pushStatement: (XCStatement* ) stmnt;
-(BOOL) hasNext;
-(BOOL) hasPrevious;
-(XCStatement*) next;
-(XCStatement*) previous;
-(XCStatement*) current;
-(void) moveToHead;
-(XCStatement*) head;
@end
