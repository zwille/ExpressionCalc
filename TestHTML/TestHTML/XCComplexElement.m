//
//  XCComplexElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElement.h"

@implementation XCComplexElement
@synthesize operands = _operands;

-(id)init{
    self = [super init];
    _operands = [NSMutableArray arrayWithCapacity:2];
    _idx = 0;
    _waitingForLiteral = YES;
    return self;
}
-(XCElement *)triggerMult {
    return (_waitingForLiteral) ? self : [super triggerMult];
}
-(XCElement *)triggerPlus {
    return (_waitingForLiteral) ? self : [super triggerPlus];
}
-(XCElement *)triggerNum:(char)c {
    if(_waitingForLiteral) {
        XCElement * num = [super triggerNum: c];
        [self setCurrentWithElement:num];
        _waitingForLiteral = NO;
        return num;
    } else {
        return self;
    }
}
-(XCElement *)triggerDel {
    NSUInteger len = [_operands count];
    if (len==0) {
        return (_root!=nil) ? _root : self;
    } else if(_idx == len) {
        [self shiftLeft];
        _waitingForLiteral=NO;
    } else if(_idx < len) {
        [_operands removeObjectAtIndex:_idx];
    } else { // remove last object
        [_operands removeObjectAtIndex:len-1];
    }
    return self;

}
-(void)setCurrentWithElement:(XCElement *)e {
    if(_idx<[_operands count]) {
        [_operands setObject:e atIndexedSubscript:_idx];
    } else {
        [_operands addObject: e];
    }
    [e setRoot:self];
}
-(void)shiftRight {
    if(_idx < [_operands count]) {
        _idx++;
    }
}
-(void)shiftLeft {
    if(_idx > 0) {
        _idx--;
    }
}
-(bool)waitingForLiteral {
    return _waitingForLiteral;
}
-(XCElement *)currentElement {
    return [_operands objectAtIndex:_idx];
}

-(NSString *)description{
    NSMutableString * buf = [NSMutableString stringWithFormat:@"%@[",[self class]];
    for (XCElement * e in _operands) {
        [buf appendFormat:@" %@",e ];
    }
    [buf appendString:@" ]"];
    return buf;
}
-(NSString *)toHTML {
    NSUInteger len = [[self operands] count];
    NSString * SQUARE = [NSString stringWithFormat:@"&#%d",XC_SYMBOL_SQUARE];
    if (len==0) {
        assert(_waitingForLiteral);
        return SQUARE;
    }
    NSMutableString * buf = [NSMutableString stringWithCapacity:4];
    NSUInteger i = 0;
    XCElement * e = (XCElement*)[_operands objectAtIndex:i];
    NSString * opStr = [self htmlFromElement: e isFirstElement: YES];
    [buf appendString: opStr];
    for (NSUInteger i = 1; i<len; i++ ) {
        e = (XCElement*)[_operands objectAtIndex:i];
        opStr = [self htmlFromElement: e isFirstElement: NO];
        [buf appendString: opStr];
    }
    if(_waitingForLiteral) {
        [buf appendFormat: @" %@ %@",[self htmlLastOp],SQUARE ];
    }
    return buf;
}
-(NSString *)htmlFromElement:(XCElement *)e isFirstElement:(bool) isFirst { return nil; }
-(NSString *)htmlLastOp{ return nil; }


@end
