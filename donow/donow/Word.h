//
//  Word.h
//  donow
//
//  Created by shirakurakento on 2013/09/11.
//
//

#import <Foundation/Foundation.h>

@interface Word : NSObject
{
    NSString *eng;
    NSString *jap;
    BOOL check;
}

@property (nonatomic, copy) NSString *eng;
@property (nonatomic, copy) NSString *jap;

+ (id)setEng:(NSString *)english andJap:(NSString *)japanese;
- (BOOL)getCheck;
- (void)setCheck:(BOOL)_check;
@end