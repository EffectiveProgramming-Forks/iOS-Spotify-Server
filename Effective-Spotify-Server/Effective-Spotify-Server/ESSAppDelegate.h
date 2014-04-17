//
//  ESSAppDelegate.h
//  Effective-Spotify-Server
//
//  Created by Eric Jones on 4/16/14.
//  Copyright (c) 2014 Effective Programming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
