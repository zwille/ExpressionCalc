//
//  XCElement.m
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCElement.h"
#import "XCNum.h"

@implementation XCElement
@synthesize root=_root;
//@synthesize head=_head;
-(XCElement *)triggerNum:(char)c {
    XCNum * num = [XCNum numWithFirstChar: c];
    [num setRoot:self];
    return num;
}
-(XCElement *)triggerPlus {
    return [_root triggerPlus];
}
-(XCElement *)triggerMult {
    return [_root triggerMult];
    
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@",[self class]];
}
-(bool)waitingForLiteral{
    return NO;
}
-(XCElement *)triggerDel {
    return nil;
}
-(NSString*) toHTML {
    return [NSString stringWithFormat:@"&#%d",XC_SYMBOL_SQUARE];
}

@end
