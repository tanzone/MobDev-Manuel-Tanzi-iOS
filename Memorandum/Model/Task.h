//
//  Task.h
//  Memorandum
//
//  Created by Manuel Tanzi on 07/09/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
{
    NSString * title;
    NSString * desc;
    NSString * lat;
    NSString * lon;
    NSString * date;
    NSString * completed;
}

- (void) setTitle:(NSString *) newTitle;
- (NSString *) title;

- (void) setDesc:(NSString *) newDesc;
- (NSString *) desc;

- (void) setLat:(NSString *) newLat;
- (NSString *) lat;

- (void) setLon:(NSString *) newLon;
- (NSString *) lon;

- (void) setDate:(NSString *) newDate;
- (NSString *) date;

-(void) setCompleted:(NSString*) newCompleted;
-(NSString*) completed;

- (NSDate *) getDate;

- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
