//
//  AppDelegate.h
//  Memorandum
//
//  Created by Manuel Tanzi on 06/09/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (readonly, strong) NSPersistentContainer * persistentContainer;

- (void) saveContext;
@end

