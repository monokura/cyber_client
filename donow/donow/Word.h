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
    int index;
}

@property (nonatomic, copy) NSString *eng;
@property (nonatomic, copy) NSString *jap;

+ (id)setEng:(NSString *)english andJap:(NSString *)japanese andIndex:(int)_index;
- (BOOL)getCheck;
- (void)setCheck:(BOOL)_check;
- (int)getIndex;
- (void)setIndex:(int)_index;
@end