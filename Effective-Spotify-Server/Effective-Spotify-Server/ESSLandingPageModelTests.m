//
//  ESSLandingPageModelTests.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ESSLandingPageModel.h"
#import "ESSServer.h"

@interface ESSLandingPageModelTests : XCTestCase

@property (nonatomic) ESSLandingPageModel *testObject;
@property (nonatomic) id mockServer;

@end

@implementation ESSLandingPageModelTests

- (void)setUp
{
    [super setUp];
    self.mockServer = [OCMockObject niceMockForClass:ESSServer.class];
    self.testObject = [[ESSLandingPageModel alloc] initWithServer:self.mockServer];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateServer_CallsESSServer_WithCorrectPortNumber {
    [[self.mockServer expect] createServerWithPort:1000];
    
    [self.testObject createServerWithPortNumberString:@"1000"];
    
    [self.mockServer verify];
}

@end
