//
//  XCKernel.m
//  TestHTML
//
//  Created by Christoph Cwelich on 04.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCKernel.h"
#import "XCExpr.h"

@implementation XCKernel
-(id<XCHasTriggers>)triggerNum:(char) c {
    _head = [_head triggerNum:c];
    //NSLog(@"num: %c",c);
    //[self log];
    return _head;
}
-(id<XCHasTriggers>)triggerOperator: (XCOperator) op {
    _head = [_head triggerOperator: op];
    return _head;
}
-(id<XCHasTriggers>)triggerEnter {
    _head = [_head triggerEnter];
    return _head;
}
-(id<XCHasTriggers>)triggerNext {
    _head = [_head triggerNext];
    return _head;
}
-(id<XCHasTriggers>)triggerPrevious {
    _head = [_head triggerPrevious];
    return _head;
}
-(id<XCHasTriggers>)triggerDel {
    _head = [_head triggerDel];
    if(_head==nil) [self reset];
    return _head;
}
-(id<XCHasTriggers>)triggerExpression {
    _head = [_head triggerExpression];
    return _head;
}
-(void)reset {
    _root = [XCExpr emptyExpressionWithRoot:nil];
    _head = _root;
}
- (void) log {
    NSString * headDesc = [NSString stringWithFormat:@"head: %@",_head];
    NSString * rootDesc = [NSString stringWithFormat:@"root: %@",_root];
    NSLog(@"%@",headDesc);
    NSLog(@"%@",rootDesc);
   
}
-(NSString *)toHTML {
    return [_root toHTML];
}
@end
