//
//  MapController.m
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import "MapController.h"

@interface MapController ()
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.map.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    
    Utility * utility = [[Utility alloc] init];
    Task * task = [[Task alloc] init];
    NSArray * array = [utility availableTask];
    
    for(int i=0; i < array.count; i++)
    {
        [task setTitle:[array[i] valueForKey:@"title"]];
        [task setLat:[array[i] valueForKey:@"lat"]];
        [task setLon:[array[i] valueForKey:@"lon"]];
        [self setPingMap:task];
    }
}

- (void)setPingMap:(Task*)task
{
    CLLocationCoordinate2D coord = {.latitude=[[task lat] doubleValue], .longitude=[[task lon] doubleValue]};
    MKCoordinateSpan span = {.latitudeDelta = 5.50f, .longitudeDelta = 5.50f};
    MKCoordinateRegion region = {coord, span};
    [self.map setRegion:region];
    
    //set pin
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    [annotation setCoordinate:coord];
    [annotation setTitle:[task title]];
    [self.map addAnnotation:annotation];
}

@end
