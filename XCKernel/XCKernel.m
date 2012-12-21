//
//  XCKernel.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCKernel.h"
#import "XCStatement.h"
#import "XCGlobal.h"
#import "XCExpression.h"

@implementation XCKernel

-(id)init{
    self = [super init];
    _statements = [[XCStatementBuffer alloc] init];
    [self newStatement];
    return self;
}

-(void)reset {
    if ([self isHeadOnStatement]) {
        [self newStatement];
        return;
    }
    [_root reset];
    [self setHead:[_root head]];
}
-(BOOL)isInExpression {
    return [[_head parent] isKindOfClass:[XCExpression class]];
}
-(void)newStatement {
    XCStatement * bufhead = [_statements head];
    if ([bufhead isEmpty]) {
        [_statements moveToHead];
        _root = bufhead;
    } else {
        _root = [XCStatement emptyStatement];
        [_statements pushStatement:_root];
        [self setHead:[_root head]];
    }
}
- (void) log {
    NSString * headDesc = [NSString stringWithFormat:@"%@",_head];
    NSString * rootDesc = [NSString stringWithFormat:@"%@",_root];
    DLOG(@"XCKernel::log head = %@",headDesc);
    DLOG(@"XCKernel::log root = %@",rootDesc);
}
-(NSString *)toHTML {
    return [_root toHTML];
}
-(NSString *)toHTMLFenced {
    return [_root toHTMLFenced];
}
-(XCElement*) setHead: (id<XCHasTriggers>) head {
    [_head setFocus:NO];
    if(head) {
        _head = (XCElement*)head;
        [_head setFocus:YES];
    } else {
       NSLog(@"XCKernel::setHead reset, triggered was null");
        [self reset];
    }
    [self log];
    return _head;
}
-(NSNumber *)eval {
    if ([_root isEmpty]) {
        return @0;
    }
    [_root normalize];
    [self setHead:_root]; //toggle focus off
    
    NSNumber * rc = [_root eval];
    return [rc isZero] ? @0 : rc;
}

-(void)previousStatement {
    if ([_statements hasPrevious]) {
        if ([_root isEmpty]) {
            [_statements removeHead];
        }
        XCStatement * prev = [_statements previous];
        _root = prev;
        [self setHead: prev];
    }
}
-(void)nextStatement {
    if ([_statements hasNext]) {
        XCStatement * next = [_statements next];
        _root = next;
        [self setHead: ([_root isEmpty]) ?
         [_root head]: _root];
    }
}
-(void)toggleAngleMode {
    XCGlobal * glob = [XCGlobal instance];
    [glob setAngleAsDegree: ![glob angleAsDegree]];
}
-(BOOL) isDegreeAngleMode {
    XCGlobal * glob = [XCGlobal instance];
    return [glob angleAsDegree];
}
-(BOOL) isHeadOnStatement {
    return [_head isKindOfClass:[XCStatement class]];
}
//trigger
-(id<XCHasTriggers>)triggerAssign: (NSUInteger)varIdx {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [_root triggerAssign:varIdx];
}
-(id<XCHasTriggers>)triggerNum:(char) c {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerNum:c]];
}
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerOperator: op]];
}
-(id<XCHasTriggers>)triggerEnter {
    if ([self isHeadOnStatement]) {
        // copy previous statements
        _root = [_root copy];
        _head = _root;
        [_statements pushStatement:_root];
    }
    return [self setHead: [_head triggerEnter]];
}
-(id<XCHasTriggers>)triggerNext {
    return [self setHead:[_head triggerNext]];
}
-(id<XCHasTriggers>)triggerPrevious {
    return [self setHead:[_head triggerPrevious]];
}
-(id<XCHasTriggers>)triggerDel {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerDel]];
}
-(id<XCHasTriggers>)triggerExpression {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerExpression]];
}

-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerConstant:cid]];
}
-(id<XCHasTriggers>)triggerFunction:(NSString *)functionName {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerFunction:functionName]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    if ([self isHeadOnStatement]) {
        [self newStatement];
    }
    return [self setHead:[_head triggerVariable:idx]];
}


@end
