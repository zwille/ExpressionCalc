//
//  XCComplexElementContentTest.m
//  TestHTML
//
//  Created by Christoph Cwelich on 05.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCComplexElementContentTest.h"
#import "XCComplexElementContent.h"
#import "XCSpacer.h"
#import "XCNum.h"
@implementation XCComplexElementContentTest

-(void) checkStateOf: (XCComplexElementContent*) cont

   withAssertedIndex: (NSUInteger) assIdx
           andLength: (NSUInteger) assLen
           ifIsEmpty: (BOOL) assEmpty
           ifHasNext: (BOOL) assHasNext
       ifHasPrevious: (BOOL) assHasPrevious {
    //NSLog(@">>> expected i=%d, l=%d, empty? %d, next? %d, prev? %d",assIdx,assLen,assEmpty,assHasNext,assHasPrevious);
   // NSLog(@">>> actual   i=%d, l=%d, empty? %d, next? %d, prev? %d",[cont index], [cont length], [cont isEmpty], [cont hasNext], [cont hasPrevious]);
    
    STAssertTrue([cont index]==assIdx,
                 @"assert %d, but was %d",assIdx, [cont index]);
    STAssertTrue([cont length]==assLen,
                 @"assert %d, but was %d",assIdx, [cont index]);
    if(assEmpty) {
        STAssertTrue([cont isEmpty], nil);
    } else {
        STAssertFalse([cont isEmpty], nil);
    }
    if(assHasNext) {
        STAssertTrue([cont hasNext], nil);
    } else {
        STAssertFalse([cont hasNext], nil);
    }
    if(assHasPrevious) {
        STAssertTrue([cont hasPrevious], nil);
    } else {
        STAssertFalse([cont hasPrevious], nil);
    }
}

-(void)testAll {
    XCComplexElementContent * cont = [[XCComplexElementContent alloc] init];
    XCElement * e0 = [XCSpacer spacerWithRoot:nil];
    XCElement * e1 = [XCNum numWithString:@"1"];
    XCElement * e2 = [XCNum numWithString:@"2"];
    XCElement * e1a = [XCNum numWithString:@"1.5"];
    XCElement * e1a2 = [XCNum numWithString:@"1.8"];
    
    //inserts
    [self checkStateOf:cont withAssertedIndex:-1 andLength:0 ifIsEmpty:YES ifHasNext:NO ifHasPrevious:NO];
    [cont insertElement:e0];
    [self checkStateOf:cont withAssertedIndex:-1 andLength:1 ifIsEmpty:NO ifHasNext:YES ifHasPrevious:NO];
    [cont nextIndex];
    STAssertEqualObjects([cont currentElement], e0, nil);
    [self checkStateOf:cont withAssertedIndex:0 andLength:1 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:NO];
    
    [cont insertElement:e1];
    [self checkStateOf:cont withAssertedIndex:0 andLength:2 ifIsEmpty:NO ifHasNext:YES ifHasPrevious:NO];
    [cont nextIndex];
    STAssertEqualObjects([cont currentElement], e1, nil);
    [self checkStateOf:cont withAssertedIndex:1 andLength:2 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:YES];
    
    [cont insertElement:e2];
    [cont nextIndex];
    STAssertEqualObjects([cont currentElement], e2, nil);
    [self checkStateOf:cont withAssertedIndex:2 andLength:3 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:YES];
    // content state: [e0,e1,<e2>]
    
    //navigate backwards
    [cont previousIndex];
    STAssertEqualObjects([cont currentElement], e1, nil);
    [self checkStateOf:cont withAssertedIndex:1 andLength:3 ifIsEmpty:NO ifHasNext:YES ifHasPrevious:YES];
    
    [cont insertElement:e1a];
    [cont nextIndex];
    STAssertEqualObjects([cont currentElement], e1a, nil);
    [self checkStateOf:cont withAssertedIndex:2 andLength:4 ifIsEmpty:NO ifHasNext:YES ifHasPrevious:YES];
    // content state: [e0,e1,<e1a>,e2]
    
    // replace
    [cont replaceCurrentWith:e1a2];
    STAssertEqualObjects([cont currentElement], e1a2, nil);
    [self checkStateOf:cont withAssertedIndex:2 andLength:4 ifIsEmpty:NO ifHasNext:YES ifHasPrevious:YES];
    // content state: [e0,e1,<e1a2>,e2]
    
    //elementAt
    STAssertEqualObjects([cont elementAtIndex:0], e0, nil);
    STAssertEqualObjects([cont elementAtIndex:1], e1, nil);
    STAssertEqualObjects([cont elementAtIndex:2], e1a2, nil);
    STAssertEqualObjects([cont elementAtIndex:3], e2, nil);
    
    //remove
    [cont removeCurrent];
    STAssertEqualObjects([cont currentElement], e2, nil);
    [self checkStateOf:cont withAssertedIndex:2 andLength:3 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:YES];
    // content state: [e0,e1,<e2>]
    [cont removeCurrent];
    STAssertEqualObjects([cont currentElement], e1, nil);
    [self checkStateOf:cont withAssertedIndex:1 andLength:2 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:YES];
    // content state: [e0,<e1>]
    [cont removeCurrent];
    STAssertEqualObjects([cont currentElement], e0, nil);
    [self checkStateOf:cont withAssertedIndex:0 andLength:1 ifIsEmpty:NO ifHasNext:NO ifHasPrevious:NO];
    // content state: [<e0>]
    [cont removeCurrent];
    [self checkStateOf:cont withAssertedIndex:-1 andLength:0 ifIsEmpty:YES ifHasNext:NO ifHasPrevious:NO];
    // content state: []
    
    
        
}

@end
