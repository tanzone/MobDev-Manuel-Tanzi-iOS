//
//  MapController.h
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "../Model/Task.h"
#import "../Model/Utility.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@end

NS_ASSUME_NONNULL_END
