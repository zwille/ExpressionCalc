//
//  XCKernel.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCKernel.h"
#import "XCStatement.h"

@implementation XCKernel

-(id)init{
    self = [super init];
    [self newStatement];
    return self;
}

-(void)reset {
    [_root reset];
    [self setHead:[_root head]];
}
-(void)newStatement {
    _root = [XCStatement emptyStatement];
    [_statements insertStatement:_root];
    [self setHead:[_root head]];
}
- (void) log {
    /*NSString * headDesc = [NSString stringWithFormat:@"%@",_head];
    NSString * rootDesc = [NSString stringWithFormat:@"%@",_root];
    NSLog(@"XCKernel head = %@",headDesc);
    NSLog(@"XCKernel root = %@",rootDesc);
    */
    //NSLog(@"XCKernel html = %@",[_root toHTML]);
}
-(NSString *)toHTML {
    return [_root toHTML];
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

//trigger
-(id<XCHasTriggers>)triggerAssign: (NSUInteger)varIdx {
    return [_root triggerAssign:varIdx];
}
-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self setHead:[_head triggerNum:c]];
}
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    return [self setHead:[_head triggerOperator: op]];
}
-(id<XCHasTriggers>)triggerEnter {
    if ([_head isKindOfClass:[XCStatement class]]
        && ![_statements hasNext]) {
        // copy previous statements
        _root = [_root copy];
        _head = _root;
        [_statements insertStatement:_root];
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
    return [self setHead:[_head triggerDel]];
}
-(id<XCHasTriggers>)triggerExpression {
    return [self setHead:[_head triggerExpression]];
}

-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return [self setHead:[_head triggerConstant:cid]];
}
-(id<XCHasTriggers>)triggerFunction:(NSString *)functionName {
    return [self setHead:[_head triggerFunction:functionName]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return [self setHead:[_head triggerVariable:idx]];
}

-(NSNumber *)eval {
    [self setHead:_root]; //toggle focus off
    return [_root eval];
}

-(void)previousStatement {
    if ([_statements hasPrevious]) {
        XCStatement * prev = [_statements previous];
        _root = prev;
        _head = prev;
    }
}
-(void)nextStatement {
    if ([_statements hasNext]) {
        XCStatement * next = [_statements previous];
        _root = next;
        _head = next;
    }
}
-(void)toggleAngleMode {
    XCGlobal * glob = [XCGlobal instance];
    [glob setAngleAsDegree: ![glob angleAsDegree]];
}
@end
