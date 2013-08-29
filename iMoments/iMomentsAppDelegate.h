//
//  iMomentsAppDelegate.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRootViewController.h"
#import "KKPasscodeLock.h"

@class STNavigationViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,KKPasscodeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) STNavigationViewController *navigationController;
+(AppDelegate *)shareAppDelegate;

- (void)saveContext;
-(void)showDir;
- (NSURL *)applicationDocumentsDirectory;

@end
