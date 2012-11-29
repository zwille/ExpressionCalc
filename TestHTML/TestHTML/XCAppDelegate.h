//
//  XCAppDelegate.h
//  TestHTML
//
//  Created by Christoph Cwelich on 29.11.12.
//  Copyright (c) 2012 Christoph Cwelich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCViewController;

@interface XCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) XCViewController *viewController;

@end
