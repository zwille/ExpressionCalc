//
//  XCElement.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {XC_SYMBOL_SQUARE = 9643} XC_SYMBOL;
@interface XCElement : NSObject {
    XCElement * _root;
   // XCElement * _head;
}
@property (strong) XCElement * root;
//@property (strong) XCElement * head;
-(XCElement*)triggerNum:(char) c;
-(XCElement*)triggerPlus;
-(XCElement*)triggerMult;
-(XCElement*)triggerDel;
-(bool) waitingForLiteral;
-(NSString*) toHTML;

@end
