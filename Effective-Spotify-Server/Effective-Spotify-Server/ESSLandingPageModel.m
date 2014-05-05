//
//  ESSLandingPageModel.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import "ESSLandingPageModel.h"

@interface ESSLandingPageModel ()

@property (nonatomic) ESSServer *server;

@end

@implementation ESSLandingPageModel

- (id)initWithServer:(ESSServer *)server {
    if (self = [super init]) {
        self.server = server;
    }
    return self;
}

//return no if invalid port or server fails to start
- (BOOL)createServerWithPortNumberString:(NSString *)numberString {
    NSInteger portNumber = [numberString integerValue];//add validation soon
    [self.server createServerWithPort:portNumber];
    return YES;
}

@end
