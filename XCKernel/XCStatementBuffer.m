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

-(void)pushStatement:(XCStatement *)stmnt {
    if([_buf isFull]) {
        XCStatement * trash = [_buf dequeue];
        [trash unlink];
    }
    [_buf push:stmnt];
    [self moveToHead];
}

-(BOOL)hasNext {
    return _idx+1 < [_buf size];
}

-(BOOL)hasPrevious {
    return _idx>0;
}
-(XCStatement *)next {
    assert([self hasNext]);
    return [_buf elementAtIndex:++_idx];
}
-(XCStatement * ) current {
    assert(_idx < [_buf size]);
    return [_buf elementAtIndex:_idx];
}
-(XCStatement *)previous {
    assert([self hasPrevious]);
    return [_buf elementAtIndex:--_idx];
}
-(XCStatement *)head {
    return [_buf head];
}
-(void)moveToHead {
    _idx = [_buf size]-1;
}
-(void)removeHead {
    assert([_buf size]>0);
    [_buf pop];

}

-(NSString *)description{
    return [NSString stringWithFormat:@"statements=%@ currentIndex=%d",_buf,_idx];
}

@end
