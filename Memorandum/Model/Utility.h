//
//  Utility.h
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Task.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utility : NSObject

- (void)saveTask:(Task*)task;
- (NSArray *)readTasks;
- (void)deleteTask:(NSManagedObject *) task;
- (void)completeTask:(NSManagedObject *) task;

- (NSArray *)orderAscTask;
- (NSArray *)orderDesTask;

- (NSArray *)orderTasks:(NSArray *)array type:(BOOL)type;

- (NSArray *)availableTask;

- (BOOL)controlDate:(NSString *) dateX;

@end

NS_ASSUME_NONNULL_END
