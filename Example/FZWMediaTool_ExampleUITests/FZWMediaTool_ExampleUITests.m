//
//  FZWMediaTool_ExampleUITests.m
//  FZWMediaTool_ExampleUITests
//
//  Created by Mentos on 2020/1/22.
//  Copyright © 2020 292017666@qq.com. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FZWMediaTool_ExampleUITests : XCTestCase

@end

@implementation FZWMediaTool_ExampleUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
//    for (int i=0; i<=100; i++) {
//        [app.buttons[@"开启相机1"] tap];
//        XCUIElement *element = [[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
//        [[[[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] tap];
//        [NSThread sleepForTimeInterval:15.f];
//        [[[[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] tap];
////        [app.buttons[@"flashLamp close@3x"] tap];
////        [app.buttons[@"flashLamp open@3x"] tap];
//        [app.buttons[@"back@3x"] tap];
//    }
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
