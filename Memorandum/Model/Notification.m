//
//  Notification.m
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import "Notification.h"

@implementation Notification



- (void)sendNotification:(Task *)task
{
    if([[task getDate] compare:[NSDate date]] != NSOrderedAscending)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;

        [center requestAuthorizationWithOptions:options
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
          if (!granted) {
            NSLog(@"Not Authorized");
          }
        }];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
          if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
              NSLog(@"Not allowed");
          }
        }];
        
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = @"Memorandum";
        content.subtitle = [task title];
        content.body = [task desc];
        content.sound = [UNNotificationSound defaultSound];
        content.userInfo = [task dictionaryRepresentation];
        content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);

        
        NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear + NSCalendarUnitMonth + NSCalendarUnitDay + NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond fromDate:[task getDate]];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger
          triggerWithDateMatchingComponents:triggerDate repeats:NO];
        
        
        CLLocationCoordinate2D point = CLLocationCoordinate2DMake([[task lat] doubleValue], [[task lon] doubleValue]);
        CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:point radius:2000.0 identifier:@"Headquarters"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = NO;
        UNLocationNotificationTrigger* locTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];

        NSString *identifier = @"UYLLocalNotification";
        UNNotificationRequest *request1 = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        [center addNotificationRequest:request1 withCompletionHandler:^(NSError * _Nullable error)
        {
            if (error != nil) NSLog(@"Something went wrong: %@",error);
        }];
        UNNotificationRequest *request2 = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:locTrigger];
        [center addNotificationRequest:request2 withCompletionHandler:^(NSError * _Nullable error)
        {
            if (error != nil) NSLog(@"Something went wrong: %@",error);
        }];
    }
}


@end
