//
//  ViewController.m
//  Memorandum
//
//  Created by Manuel Tanzi on 06/09/22.
//

#import "AddTaskController.h"


@interface AddTaskController ()

@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UILabel *txtLat;
@property (weak, nonatomic) IBOutlet UILabel *txtLon;
@property (weak, nonatomic) IBOutlet UIDatePicker *txtDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addDone;
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end

@implementation AddTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.isDetail)
    {
        [self setDetail];
        [self setMap];
    }
}

-(void)setDetail
{
    self.txtTitle.text = self.titl;
    self.txtTitle.userInteractionEnabled = NO;
    self.txtDesc.text = self.desc;
    self.txtDesc.userInteractionEnabled = NO;
    self.txtLat.text = self.lat;
    self.txtLat.userInteractionEnabled = NO;
    self.txtLon.text = self.lon;
    self.txtLon.userInteractionEnabled = NO;
    self.txtDate.userInteractionEnabled = NO;
    [self.addDone setEnabled:NO];
    [self.addDone setTintColor: [UIColor clearColor]];
    [self performSelector:@selector(setDatePicker) withObject:nil afterDelay:(0.5)];
}

- (void)setDatePicker
{
    [self.txtDate setDate:self.date animated:YES];
}

- (void)setMap
{
    CLLocationCoordinate2D coord = {.latitude=[self.lat doubleValue], .longitude=[self.lon doubleValue]};
    MKCoordinateSpan span = {.latitudeDelta = 0.050f, .longitudeDelta = 0.050f};
    MKCoordinateRegion region = {coord, span};
    [self.map setRegion:region];
    
    //set pin
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    [annotation setCoordinate:coord];
    [annotation setTitle:@"Task is here"];
    [self.map addAnnotation:annotation];
}


- (IBAction)addDone:(id)sender {
    Task * task = [self getInfoTask];
    if([self checkInfoTask:task])
    {
        Notification * notif = [[Notification alloc] init];
        [notif sendNotification:task];
        Utility * utility = [[Utility alloc] init];
        [utility saveTask:task];
        [self openMainView];
    }
}

- (Task *)getInfoTask{
    NSString * title = self.txtTitle.text;
    NSString * desc = self.txtDesc.text;
    NSString * lat = self.txtLat.text;
    NSString * lon = self.txtLon.text;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MMMM/yyyy HH:mm";
    NSString * date = [formatter stringFromDate: self.txtDate.date];
    
    Task * task = [[Task alloc] init];
    [task setTitle:title];
    [task setDesc:desc];
    [task setLat:lat];
    [task setLon:lon];
    [task setDate:date];
    [task setCompleted:@"0"];
    
    return task;
}

- (BOOL)checkInfoTask:(Task *)task {
    if([[task title] length] == 0){
        [self showAlert:@"Warning !" message:@"Please insert a title on your task" button:@"OK" cancel:@""];
        return false;
    }
    if([[task desc] length] == 0){
        [self showAlert:@"Warning !" message:@"Please insert a description on your task" button:@"OK" cancel:@""];
        return false;
    }
    if([[task lat]  isEqual: @"coord."] || [[task lon]  isEqual: @"coord."]){
        [self showAlert:@"Warning !" message:@"Please take a position on your task" button:@"OK" cancel:@""];
        return false;
    }
    if([task getDate])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MMMM/yyyy HH:mm"];
        NSString *strToday = [dateFormatter  stringFromDate:[NSDate date]];
        NSDate *todaydate = [dateFormatter dateFromString:strToday];
        
        if([[task getDate] compare: todaydate] == NSOrderedSame){
            [self showAlert:@" ! Attention ! " message:@"The date selected is the same be careful and the task will NOT be shown" button:@"OK" cancel:@"Cancel"];
            return false;
        }
        else if([[task getDate] compare: todaydate] == NSOrderedAscending){
            [self showAlert:@" ! Attention ! " message:@"The date selected is first than today, the task will NOT be shown" button:@"OK" cancel:@"Cancel"];
            return false;
        }
        return true;
    }
    else return false;
}

-(void)showAlert:(NSString*)title message:(NSString*)message button:(NSString*)button cancel:(NSString*)cancel{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: title
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    
    if([cancel length] == 0)
    {
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
    }
    else if([cancel length] != 0)
    {
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:cancel
            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {[self okAlert];}];
        [alert addAction:secondAction];
        [alert addAction:defaultAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)okAlert
{
    Task * task = [self getInfoTask];
    Utility * utility = [[Utility alloc] init];
    [utility saveTask:task];
    [self openMainView];
}


- (void)openMainView
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addPin:(UILongPressGestureRecognizer *)sender
{
    if (sender.state != UIGestureRecognizerStateEnded) return;
    
    if(![self.txtLat.text isEqual: @"coord."] || ![self.txtLon.text isEqual: @"coord."])
        [self.map removeAnnotations:self.map.annotations];

    CGPoint touchPoint = [sender locationInView:self.map];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.map convertPoint:touchPoint toCoordinateFromView:self.map];

    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    
    if([self.txtTitle.text length] == 0) pa.title = @"Task is here";
    else                                 pa.title = self.txtTitle.text;
    
    [self.map addAnnotation:pa];
    
    self.txtLat.text = [NSString stringWithFormat:@"%.8lf", pa.coordinate.latitude];
    self.txtLon.text = [NSString stringWithFormat:@"%.8lf", pa.coordinate.longitude];
}

@end
