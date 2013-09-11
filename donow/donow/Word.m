//
//  Word.m
//  donow
//
//  Created by shirakurakento on 2013/09/11.
//
//

#import "Word.h"

@implementation Word
@synthesize eng;
@synthesize jap;

+ (id)setEng:(NSString *)english andJap:(NSString *)japanese andIndex:(int)_index
{
    Word *newWord = [[Word alloc] init];
    [newWord setEng:english];
    [newWord setJap:japanese];
    [newWord setCheck:NO];
    [newWord setIndex:_index];
    return newWord;
}

-(BOOL)getCheck
{
    return check;
}

-(void)setCheck:(BOOL)_check
{
    check = _check;
}

-(int)getIndex
{
    return index;
}

-(void)setIndex:(int)_index
{
    index = _index;
}
@end
