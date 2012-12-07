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
    [self reset];
    return self;
}

-(void)reset {
    _root = [XCStatement emptyStatement];
    [self setHeadWithTriggered:[_root head]];
}
- (void) log {
    NSString * headDesc = [NSString stringWithFormat:@"%@",_head];
    NSString * rootDesc = [NSString stringWithFormat:@"%@",_root];
    NSLog(@"XCKernel head = %@",headDesc);
    NSLog(@"XCKernel root = %@",rootDesc);
    NSLog(@"XCKernel html = %@",[_root toHTML]);
}
-(NSString *)toHTML {
    return [_root toHTML];
}
-(XCElement*) setHeadWithTriggered: (id<XCHasTriggers>) triggered {
    [_head setFocus:NO];
    if(triggered) {
        _head = (XCElement*)triggered;
        [_head setFocus:YES];
    } else {
        NSLog(@"XCKernel::setHead reset, triggered was null");
        [self reset];
    }
    [self log];
    return _head;
}

//trigger
-(id<XCHasTriggers>)triggerNum:(char) c {
    return [self setHeadWithTriggered:[_head triggerNum:c]];
}
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    return [self setHeadWithTriggered:[_head triggerOperator: op]];
}
-(id<XCHasTriggers>)triggerEnter {
    return [self setHeadWithTriggered:[_head triggerEnter]];
}
-(id<XCHasTriggers>)triggerNext {
    return [self setHeadWithTriggered:[_head triggerNext]];
}
-(id<XCHasTriggers>)triggerPrevious {
    return [self setHeadWithTriggered:[_head triggerPrevious]];
}
-(id<XCHasTriggers>)triggerDel {
    return [self setHeadWithTriggered:[_head triggerDel]];
}
-(id<XCHasTriggers>)triggerExpression {
    return [self setHeadWithTriggered:[_head triggerExpression]];
}
-(id<XCHasTriggers>)triggerAssign:(NSUInteger)varIdx {
    return [self setHeadWithTriggered:[_head triggerAssign:varIdx]];
}
-(id<XCHasTriggers>)triggerConstant:(XCConstants)cid {
    return [self setHeadWithTriggered:[_head triggerConstant:cid]];
}
-(id<XCHasTriggers>)triggerFunction:(NSString *)functionName {
    return [self setHeadWithTriggered:[_head triggerFunction:functionName]];
}
-(id<XCHasTriggers>)triggerVariable:(NSUInteger)idx {
    return [self setHeadWithTriggered:[_head triggerVariable:idx]];
}

-(NSNumber *)eval {
    return [_root eval];
}
@end
