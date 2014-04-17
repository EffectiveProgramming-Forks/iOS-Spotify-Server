//
//  ESSServer.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 4/16/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import "ESSServer.h"

@interface ESSServer ()

@property (nonatomic) MongooseServer *server;

@end

@implementation ESSServer

- (id)initWithServerPort:(NSInteger)portNumber {
    if (self = [super init]) {

        self.server = [[MongooseServer alloc] initWithPort:portNumber allowDirectoryListing:YES];
        
    }
    
    return self;
}

@end
