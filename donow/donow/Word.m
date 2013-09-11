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

+ (id)setEng:(NSString *)english andJap:(NSString *)japanese
{
    Word *newWord = [[Word alloc] init];
    [newWord setEng:english];
    [newWord setJap:japanese];
    [newWord setCheck:NO];
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

@end
