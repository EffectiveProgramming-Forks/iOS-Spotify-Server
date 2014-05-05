//
//  ESSServer.h
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 4/16/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MongooseServer.h"



@interface ESSServer : NSObject

- (void)createServerWithPort:(NSInteger)portNumber;

@end
