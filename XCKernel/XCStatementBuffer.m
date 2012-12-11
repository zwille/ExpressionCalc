//
//  XCStatementBuffer.m
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCStatementBuffer.h"
#define BUF_MAX 8
@implementation XCStatementBuffer
-(id)init {
    self = [super init];
    _idx = 0;
    _buf = [[XCCircBuf alloc] initWithMaxSize:BUF_MAX];
    return self;
}

-(void)insertStatement:(XCStatement *)stmnt {
    if([_buf isFull]) {
        [_buf dequeue];
    }
    [_buf push:stmnt];
    _idx = [_buf size];
}

-(BOOL)hasNext {
    return _idx < [_buf size];
}

-(BOOL)hasPrevious {
    return !_idx;
}
-(XCStatement *)next {
    assert([self hasNext]);
    return [_buf elementAtIndex:++_idx];
}
-(XCStatement *)previous {
    assert([self hasPrevious]);
    return [_buf elementAtIndex:--_idx];
}

@end
