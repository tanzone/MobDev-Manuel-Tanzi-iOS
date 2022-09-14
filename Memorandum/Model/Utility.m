//
//  Utility.m
//  Memorandum
//
//  Created by Manuel Tanzi on 09/09/22.
//

#import "Utility.h"

@implementation Utility


- (void)saveTask:(Task*)task
{
    //Get Context
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = appDelegate.persistentContainer.viewContext;
    
    //Take data
    NSManagedObject *entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:context];
    [entityObj setValue:[task title] forKey:@"title"];
    [entityObj setValue:[task desc] forKey:@"desc"];
    [entityObj setValue:[task lat] forKey:@"lat"];
    [entityObj setValue:[task lon] forKey:@"lon"];
    [entityObj setValue:[task date] forKey:@"date"];
    [entityObj setValue:[task completed] forKey:@"completed"];
    
    //Save
    [appDelegate saveContext];
}

- (NSArray *)readTasks
{
    //Get Context
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = appDelegate.persistentContainer.viewContext;
    // Fet (Load) Data
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    return [context executeFetchRequest:requestExamLocation error:nil];
}

- (void)deleteTask:(NSManagedObject *)task
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = appDelegate.persistentContainer.viewContext;
    [context deleteObject:task];
    
    NSError * error = nil;
    if (![context save:&error])
    {
        NSLog(@"Error ! %@", error);
    }
}

- (NSArray *)orderAscTask
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    return [[self readTasks] sortedArrayUsingDescriptors:descriptors];
}

- (NSArray *)orderDesTask
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    return [[self readTasks] sortedArrayUsingDescriptors:descriptors];
}


- (NSArray *)orderTasks:(NSArray *)array type:(BOOL)type
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:type];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    return [array sortedArrayUsingDescriptors:descriptors];
}



- (NSArray *)availableTask
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MMMM/yyyy HH:mm"];
    NSString *strToday = [dateFormatter  stringFromDate:[NSDate date]];
    NSDate *todaydate = [dateFormatter dateFromString:strToday];
    
    NSArray * array = [self readTasks];
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++)
    {
        NSDate * date = [dateFormatter dateFromString:[array[i] valueForKey:@"date"]];
        NSString * complete = [array[i] valueForKey:@"completed"];
        if(([todaydate compare: date] == NSOrderedAscending) && ([complete isEqual: @"0"]))
            [result addObject:array[i]];
    }
    
    return result;
}

- (void)completeTask:(NSManagedObject *)task
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = appDelegate.persistentContainer.viewContext;
    [context deleteObject:task];
    
    NSManagedObject *entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:context];
    [entityObj setValue:[task valueForKey:@"title"] forKey:@"title"];
    [entityObj setValue:[task valueForKey:@"desc"] forKey:@"desc"];
    [entityObj setValue:[task valueForKey:@"lat"] forKey:@"lat"];
    [entityObj setValue:[task valueForKey:@"lon"] forKey:@"lon"];
    [entityObj setValue:[task valueForKey:@"date"] forKey:@"date"];
    [entityObj setValue:@"1" forKey:@"completed"];
    
    [appDelegate saveContext];
}



- (BOOL)controlDate:(NSString *) dateX
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MMMM/yyyy HH:mm"];
    NSString *strToday = [dateFormatter  stringFromDate:[NSDate date]];
    NSDate *todaydate = [dateFormatter dateFromString:strToday];
    NSDate * date = [dateFormatter dateFromString:dateX];
    
    if(([todaydate compare: date] == NSOrderedAscending))
        return NO;
    return YES;
}


@end
