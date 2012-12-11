//
//  XCComplexElementContentTest.h
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface XCComplexElementContentTest : SenTestCase
-(void)testAll;

@end
/*
checkStateOf {
index;
length;
isEmpty;
hasNext;
hasPrevious;
}
     
-(XCElement*) currentElement;
-(XCElement*) elementAtIndex: (NSUInteger) index;
-(NSUInteger) nextIndex;
-(NSUInteger) previousIndex;
-(void) insertElement: (XCElement*) element;
-(void) removeCurrent;
-(void) replaceCurrentWith: (XCElement*) element;
*/