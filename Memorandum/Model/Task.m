//
//  Task.m
//  Memorandum
//
//  Created by Manuel Tanzi on 07/09/22.
//

#import "Task.h"

@implementation Task

- (void) setTitle:(NSString *)newTitle{
    title = newTitle;
}
- (NSString *) title{
    return title;
}

- (void)setDesc:(NSString *)newDesc{
    desc = newDesc;
}
- (NSString *)desc{
    return desc;
}

- (void)setLat:(NSString *)newLat{
    lat = newLat;
}
- (NSString *)lat{
    return lat;
}

- (void)setLon:(NSString *)newLon{
    lon = newLon;
}
- (NSString *)lon{
    return lon;
}

- (void)setDate:(NSString *)newDate{
    date = newDate;
}
- (NSString *)date{
    return date;
}

- (void)setCompleted:(NSString*)newCompleted
{
    completed = newCompleted;
}
- (NSString *)completed
{
    return completed;
}

- (NSDate *)getDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MMMM/yyyy HH:mm"];
    return [dateFormatter dateFromString:[self date]];
}


- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

    [mutableDict setValue:self.title forKey:@"title"];
    [mutableDict setValue:self.desc forKey:@"desc"];
    [mutableDict setValue:self.lat forKey:@"lat"];
    [mutableDict setValue:self.lon forKey:@"lon"];
    [mutableDict setValue:self.date forKey:@"date"];


    return [NSDictionary dictionaryWithDictionary:mutableDict];
}
@end
