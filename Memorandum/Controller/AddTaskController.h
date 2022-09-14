//
//  ViewController.h
//  Memorandum
//
//  Created by Manuel Tanzi on 06/09/22.
//

#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "Task.h"
#import "../Model/Utility.h"
#import "../Model/Notification.h"

@interface AddTaskController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSString * titl;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * lon;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, assign) BOOL  isDetail;


@end

