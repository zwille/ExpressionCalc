//
//  XCFunction.h
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCSimpleElement.h"
#import "XCFuncAlg.h"
@interface XCFunction : XCSimpleElement {
    NSString * _name;
}
+(XCFunction *)functionWithName: (NSString* ) name
                    withElement: (XCElement *) element
                        andRoot: (XCElement *) root;
@end
