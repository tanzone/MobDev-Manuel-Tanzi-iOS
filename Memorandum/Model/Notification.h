//
//  Notification.h
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notification : NSObject

- (void)sendNotification:(Task *)task;

@end

NS_ASSUME_NONNULL_END
