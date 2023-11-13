//
//  demoTests.m
//  demoTests
//
//  Created by Abakus on 2023/6/25.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface demoTests : XCTestCase

@property(strong, nonatomic) ViewController *vc;

@end

@implementation demoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [ViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(100, [self.vc getSum100], @"测试不通过");
}

//异步测试 XCTestExpectation  新建期望 、 等待期望被履行 和 履行期望
- (void)testAsync{
    XCTestExpectation *expect3 = [[XCTestExpectation alloc] initWithDescription:@"asyncTest3"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bilibili.com"]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, 200, @"测试不通过");
        [expect3 fulfill];
    }] resume];

    [self waitForExpectations:@[expect3] timeout:10.0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for(int i = 0; i < 1000000; i ++)
            [self.vc getSum100];
    }];
}

@end
