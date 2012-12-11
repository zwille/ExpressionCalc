//
//  XCTestCircBuf.m
//  XCCalc
//
//  Created by Christoph Cwelich on 10.12.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import "XCTestCircBuf.h"
#import "XCCircBuf.h"

@implementation XCTestCircBuf
-(void)checkStateWithCircBuf: (XCCircBuf*) cb
             assertedMaxSize: (NSUInteger) maxSize
                     andSize: (NSUInteger) size
                     ifEmpty: (BOOL) isEmpty
                      ifFull: (BOOL) isFull
               elementAtHead: (id) head
               elementAtTail: (id) tail {
    //NSLog(@">>> XCTestCircBuf cb: %@",cb);
    STAssertTrue([cb maxSize]==maxSize, nil);
    STAssertTrue([cb size]==size, nil);
    STAssertTrue([cb isEmpty]==isEmpty, nil);
    STAssertTrue([cb isFull]==isFull, nil);
    STAssertEqualObjects(head, [cb head], nil);
    STAssertEqualObjects(tail, [cb tail], nil);
}
-(void)testAll {
    XCCircBuf * cb = [[XCCircBuf alloc] initWithMaxSize:0];
    [self checkStateWithCircBuf:cb
                assertedMaxSize:0
                        andSize:0
                        ifEmpty:YES
                         ifFull:YES
                  elementAtHead:nil
                  elementAtTail:nil];
    STAssertFalse([cb push:@0], nil);
   // NSLog(@"%@",cb);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:0
                        andSize:0
                        ifEmpty:YES
                         ifFull:YES
                  elementAtHead:nil
                  elementAtTail:nil];
    cb = [[XCCircBuf alloc] initWithMaxSize:1];
    [self checkStateWithCircBuf:cb
                assertedMaxSize:1
                        andSize:0
                        ifEmpty:YES
                         ifFull:NO
                  elementAtHead:nil
                  elementAtTail:nil];
    STAssertTrue([cb push:@0], nil);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:1
                        andSize:1
                        ifEmpty:NO
                         ifFull:YES
                  elementAtHead:@0
                  elementAtTail:@0];
    //NSLog(@"%@",cb);
    STAssertEqualObjects([cb dequeue], @0,nil);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:1
                        andSize:0
                        ifEmpty:YES
                         ifFull:NO
                  elementAtHead:nil
                  elementAtTail:nil];
    cb = [[XCCircBuf alloc] initWithMaxSize:3];
    STAssertTrue([cb push:@0], nil);
    STAssertTrue([cb push:@1], nil);
    STAssertTrue([cb push:@2], nil);
    STAssertFalse([cb push:@3], nil);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:3
                        andSize:3
                        ifEmpty:NO
                         ifFull:YES
                  elementAtHead:@2
                  elementAtTail:@0];
    STAssertEqualObjects([cb dequeue], @0,nil);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:3
                        andSize:2
                        ifEmpty:NO
                         ifFull:NO
                  elementAtHead:@2
                  elementAtTail:@1];
    STAssertTrue([cb push:@3], nil);
    [self checkStateWithCircBuf:cb
                assertedMaxSize:3
                        andSize:3
                        ifEmpty:NO
                         ifFull:YES
                  elementAtHead:@3
                  elementAtTail:@1];
    STAssertEqualObjects([cb elementAtIndex:0], @1, nil);
    STAssertEqualObjects([cb elementAtIndex:1], @2, nil);
    STAssertEqualObjects([cb elementAtIndex:2], @3, nil);
    STAssertEqualObjects([cb elementAtIndex:3], @1, nil);
    
    

}
@end
