//
//  MainController.m
//  Memorandum
//
//  Created by Manuel Tanzi on 07/09/22.
//

#import "MainController.h"

@interface MainController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnVisualize;
@property (nonatomic, strong) NSMutableArray * taskList;
@property BOOL allTasks;

@end

@implementation MainController

- (void)viewDidLoad { [super viewDidLoad]; self.allTasks = NO;}

- (void)viewWillAppear:(BOOL)animated
{
    Utility * utility = [[Utility alloc] init];
    if(!self.allTasks)
        self.taskList = [[NSMutableArray alloc] initWithArray: [utility orderTasks:utility.availableTask type:YES]];
    else
        self.taskList = [[NSMutableArray alloc] initWithArray:utility.orderAscTask];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Utility * utility = [[Utility alloc] init];
    NSString * id = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id forIndexPath:indexPath];
    
    NSString * title = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"title"];
    NSString * date = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"date"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = date;
    
    if([[[self.taskList objectAtIndex:indexPath.row] valueForKey:@"completed"] isEqual: @"1"])
        cell.backgroundColor = [UIColor colorWithRed:215/255.0 green:192/255.0 blue:174/255.0 alpha:1];
    else if([utility controlDate:[[self.taskList objectAtIndex:indexPath.row] valueForKey:@"date"]])
        cell.backgroundColor = [UIColor lightGrayColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddTaskController * addTask= [self.storyboard instantiateViewControllerWithIdentifier:@"addTask"];
    
    addTask.titl = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"title"];
    addTask.desc = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"desc"];
    addTask.lat = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"lat"];
    addTask.lon = [[self.taskList objectAtIndex:indexPath.row] valueForKey:@"lon"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MMMM/yyyy HH:mm"];
    addTask.date = [dateFormatter dateFromString:[[self.taskList objectAtIndex:indexPath.row] valueForKey:@"date"]];
    addTask.isDetail = YES;
    
    [self.navigationController pushViewController:addTask animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UISwipeActionsConfiguration *swipeActionConfig = [[UISwipeActionsConfiguration alloc] init];
    
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"DELETE" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL))
    {
        [self taskToRemove:indexPath];
        [self.taskList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        completionHandler(YES);
        
    }];
    delete.backgroundColor = [UIColor redColor];

    UIContextualAction *more = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"COMPLETE" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL))
    {
        Utility * utility = [[Utility alloc] init];
        [utility completeTask:[self.taskList objectAtIndex:indexPath.row]];
        self.taskList = [[NSMutableArray alloc] initWithArray: [utility orderTasks:utility.availableTask type:YES]];
        [self.tableView reloadData];
        completionHandler(YES);
        
    }];
    more.backgroundColor = [UIColor systemBrownColor];
    
    if([[[self.taskList objectAtIndex:indexPath.row] valueForKey:@"completed"] isEqual: @"1"])
        swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
    else
        swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete, more]];
    
    swipeActionConfig.performsFirstActionWithFullSwipe = NO;

    return swipeActionConfig;
}

- (void)taskToRemove:(NSIndexPath *)index
{
    Utility * utility = [[Utility alloc] init];
    [utility deleteTask:[self.taskList objectAtIndex:index.row]];
}



- (IBAction)visualizeAllTasks:(id)sender
{
    Utility * utility = [[Utility alloc] init];
    UIImage *image;
    if(self.allTasks)
    {
        image = [UIImage systemImageNamed:@"archivebox"];
        self.taskList = [[NSMutableArray alloc] initWithArray: [utility orderTasks:utility.availableTask type:YES]];
    }
    else
    {
        image = [UIImage systemImageNamed:@"xmark.bin"];
        self.taskList = [[NSMutableArray alloc] initWithArray:utility.orderAscTask];
    }
    [self.btnVisualize setImage: image];
    self.allTasks = !(self.allTasks);
    [self.tableView reloadData];
}


@end
