//
//  ESSLandingPageViewControllerTests.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ESSLandingPageViewController.h"
#import "ESSLandingPageView.h"
#import "ESSLandingPageModel.h"

@interface ESSLandingPageViewController () <ESSLandingPageViewProtocol>

- (void)setupControllerWithView:(ESSLandingPageView *)view model:(ESSLandingPageModel *)model;

@end

@interface ESSLandingPageViewControllerTests : XCTestCase

@property (nonatomic) ESSLandingPageViewController *testObject;
@property (nonatomic) id mockLandingPageModel;
@property (nonatomic) id mockLandingPageView;

@end

@implementation ESSLandingPageViewControllerTests

- (void)setUp
{
    [super setUp];
    self.mockLandingPageView = [OCMockObject niceMockForClass:ESSLandingPageView.class];
    self.mockLandingPageModel = [OCMockObject niceMockForClass:ESSLandingPageModel.class];
    self.testObject = [[ESSLandingPageViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}

- (void)testSetup_SetsSelfAsDelegateOnModel {
    [[self.mockLandingPageView expect] setDelegate:self.testObject];
    
    [self.testObject setupControllerWithView:self.mockLandingPageView model:self.mockLandingPageModel];
    
    [self.mockLandingPageView verify];
}

@end
