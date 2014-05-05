//
//  ESSLandingPageView.m
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 5/5/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import "ESSLandingPageView.h"

@interface ESSLandingPageView ()

@property (strong, nonatomic) IBOutlet UILabel *serverPortLabel;
@property (strong, nonatomic) IBOutlet UITextField *serverPortTextField;
@property (strong, nonatomic) IBOutlet UILabel *serverPortStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *startServerButton;

@end

@implementation ESSLandingPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)startServerButtonPressed:(id)sender {
    
    [self.delegate startButtonPressedWithPortNumber:self.serverPortTextField.text];
    
}

@end
