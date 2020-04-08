//
//  SoccerManagerUITests.m
//  SoccerManagerUITests
//
//  Created by ihandysoft on 15/12/22.
//  Copyright © 2015年 ihandysoft. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SoccerManagerUITests : XCTestCase

@end

@implementation SoccerManagerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"\u53d1\u73b0"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
        [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\u5176\u5b83"]/*[[".cells.staticTexts[@\"\\u5176\\u5b83\"]",".staticTexts[@\"\\u5176\\u5b83\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeUp];
    [tablesQuery.staticTexts[@"\u5708\u5b50"] tap];
    
    XCUIElement *navcBackButton = app.navigationBars[@"\u53d1\u73b0"].buttons[@"navc back"];
    [navcBackButton tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\u8bba\u575b"]/*[[".cells.staticTexts[@\"\\u8bba\\u575b\"]",".staticTexts[@\"\\u8bba\\u575b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\u7ade\u731c"]/*[[".cells.staticTexts[@\"\\u7ade\\u731c\"]",".staticTexts[@\"\\u7ade\\u731c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"\u56fe\u7247"]/*[[".cells.staticTexts[@\"\\u56fe\\u7247\"]",".staticTexts[@\"\\u56fe\\u7247\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [navcBackButton tap];
    
}

@end
