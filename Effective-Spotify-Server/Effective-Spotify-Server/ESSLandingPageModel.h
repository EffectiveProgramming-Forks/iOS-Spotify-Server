//
//  ESSLandingPageModel.h
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESSServer.h"

@interface ESSLandingPageModel : NSObject

- (id)initWithServer:(ESSServer *)server;
- (BOOL)createServerWithPortNumberString:(NSString *)numberString;

@end
