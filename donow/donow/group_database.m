//
//  group_database.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "group_database.h"

@implementation group_database
@synthesize category;
@synthesize name;
+ (id)groupOfCategory:(NSString *)category name:(NSString *)name
{
    group_database *newGroup = [[self alloc] init];
    [newGroup setCategory:category];
    [newGroup setName:name];
    return newGroup;
}

@end