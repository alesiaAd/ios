//
//  RSSchool_T4Tests.m
//  RSSchool_T4Tests
//
//  Created by Alesia Adereyko on 20/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PhoneNumberFormatter.h"

@interface RSSchool_T4Tests : XCTestCase

@end

@implementation RSSchool_T4Tests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testReturnNumber {
    NSString * test = [PhoneNumberFormatter formatPhoneNumber:@"375295519138"].formattedValue;
    XCTAssertTrue([test isEqualToString:@"+375 (29) 551-91-38"]);
}

- (void)testReturnNumber1 {
    NSString * test = [PhoneNumberFormatter formatPhoneNumber:@"37329551913"].formattedValue;
    XCTAssertTrue([test isEqualToString:@"+373 (29) 551-913"]);
}

- (void)testReturnNumber2 {
    NSString * test = [PhoneNumberFormatter formatPhoneNumber:@"72995519138"].formattedValue;
    XCTAssertTrue([test isEqualToString:@"+7 (299) 551 91 38"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
