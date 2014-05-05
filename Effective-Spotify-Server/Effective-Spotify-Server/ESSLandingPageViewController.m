//
//  ESSLandingPageViewController.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import "ESSLandingPageViewController.h"
#import "ESSLandingPageView.h"
#import "ESSLandingPageModel.h"
#import "ESSServer.h"

@interface ESSLandingPageViewController () <ESSLandingPageViewProtocol>

@property (nonatomic) ESSLandingPageView *landingPageView;
@property (nonatomic) ESSLandingPageModel *landingPageModel;

@end

@implementation ESSLandingPageViewController

- (void)setupControllerWithView:(ESSLandingPageView *)view model:(ESSLandingPageModel *)model {
    self.landingPageView = view;
    self.landingPageView.delegate = self;
    self.landingPageModel = model;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ESSLandingPageModel *model = [[ESSLandingPageModel alloc] initWithServer:[[ESSServer alloc] init]];
    [self setupControllerWithView:(ESSLandingPageView *)self.view model:model];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ESSLandingPageViewDelegate

-(void)startButtonPressedWithPortNumber:(NSString *)portNumber {
    if ([self.landingPageModel createServerWithPortNumberString:portNumber]) {
        //start Successfull
    } else {
        //startFailure
    }
}

@end
