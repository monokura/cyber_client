//
//  group_database.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <Foundation/Foundation.h>

@interface group_database : NSObject{
    NSString *category;
    NSString *name;
}
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)groupOfCategory:(NSString*)category name:(NSString*)name;


@end

