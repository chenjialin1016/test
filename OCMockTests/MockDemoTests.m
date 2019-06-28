//
//  MockDemoTests.m
//  OCMockTests
//
//  Created by Jialin Chen on 2019/6/19.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "OCMockTests-Swift.h"

@interface MockDemoTests : XCTestCase

@end

@implementation MockDemoTests

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

//最简单的一个使用ocmock的例子:mock一个模型类
- (void)testPersonNameEqual{
    Person *person = [[Person alloc] init];
    //创建一个mock对象
    id mockClass = OCMClassMock([Person class]);
    //可以给这个mock对象的方法设置预设的参数和返回值
    OCMStub([mockClass getPersonName]).andReturn(@"小李");
    
    //用这个预设的值和实际的值进行比较
    XCTAssertEqualObjects([mockClass getPersonName], [person getPersonName],@"值相等");
}

//例子1 类mock----OCMClassMock([TwitterConnection class]);
/*
 当我们为updateTweetView来写一个测试类的时候我们要考虑它有哪些相对应的依赖，也就是TwitterConnection和TweetView。在这个例子里我们需要实例化一个真正的TwitterConnection对象来请求真实数据然后使用它。这样的话会有几个问题：
 
        使用真实的connection会使测试变慢，因为它还要去请求网络。
        我们永远不知道每一次Twitter返回的数据是什么。
        很难测试错误的返回，因为Twitter一般不会返回错误。
 
 解决的方法就是伪造一个假的connection，既一个stub。
 */
- (void)testMockingAnObject{
    
    //模拟出来一个网络请求链接的数据类
    id mockConnection = OCMClassMock([TwitterConnection class]);
    //模拟fetchdata方法返回预设置
    OCMStub([mockConnection fetchData]).andReturn(@"stubbed!");
    
    TwitterViewController *controller = [TwitterViewController newController];
    controller.connection = mockConnection;

    //这里执行redisplay之后，返回 stubbed
    [controller redisplay];
    
    //-------验证使用对应参数的方法是否被调用------
    
    //成功
    OCMVerify([mockConnection fetchData]);
    XCTAssertEqualObjects(@"stubbed!", controller.data, @"Excpected stubbed data in controller.");
    
    //失败
//    XCTAssertEqualObjects(@"real data returned from other system", controller.data, @"unExcpected stubbed data in controller.");
}

//例子2 部分mock，使用的是新建的connection----OCMPartialMock(testConnection);
/*
 这样创建的对象在调用方法时:
 如果方法被stub,调用stub后的方法.
 如果方法没有被stub,调用原来的对象的方法.
 partialMock 对象在调用方法后,可以用于稍后的验证此方法的调用情况(被调用,调用结果)
 */
- (void)testPartiallyMockingAnObject
{
    //新建一个connection用来mock
    TwitterConnection * testConnection = [TwitterConnection new];
    id mockConnection = OCMPartialMock(testConnection);
    OCMStub([mockConnection fetchData]).andReturn(@"stubbed!");
    
    TwitterViewController *controller = [TwitterViewController newController];
    [controller redisplay];
    
    //-------验证使用对应参数的方法是否被调用------
    //失败
    OCMVerify([mockConnection fetchData]);
    XCTAssertEqualObjects(@"stubbed!", controller.data, @"Excpected stubbed data in controller.");
}

//例子3 部分mock，使用的是controller的connection----OCMPartialMock((NSObject *)controller.connection);
- (void)testPartiallyMockingAnObject2
{
    TwitterViewController *controller = [TwitterViewController newController];
    
    //从controller中获取mock对象
    id mockConnection = OCMPartialMock((NSObject *)controller.connection);
    OCMStub([mockConnection fetchData]).andReturn(@"stubbed!");
    
    [controller redisplay];
    
     //-------验证使用对应参数的方法是否被调用------
    //成功
    OCMVerify([mockConnection fetchData]);
    XCTAssertEqualObjects(@"stubbed!", controller.data, @"Excpected stubbed data in controller.");
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
