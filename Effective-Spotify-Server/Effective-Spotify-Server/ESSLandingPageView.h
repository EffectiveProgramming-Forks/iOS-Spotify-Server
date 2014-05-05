//
//  ESSLandingPageView.h
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESSLandingPageViewProtocol <NSObject>

- (void)startButtonPressedWithPortNumber:(NSString *)portNumber;

@end

@interface ESSLandingPageView : UIView

@property (nonatomic, weak) id<ESSLandingPageViewProtocol> delegate;

@end
