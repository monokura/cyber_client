//
//  HttpRequest.m
//  HttpTest
//
//  Created by shirakurakento on 2013/09/08.
//  Copyright (c) 2013年 shirakurakento. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
-(id)init{
    self = [super init];
    if(self != nil){
        url = @"http://ec2-54-249-8-59.ap-northeast-1.compute.amazonaws.com:3000";
        root = nil;
        query = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)setRoot:(NSMutableString *)_root
{
    root = _root;
}

-(void)addKey:(NSString *)key andValue:(NSString *)value
{
    [query setObject:value forKey:key];
    }

-(NSString *)makeUriGet{
    NSMutableString *tmp = [NSMutableString stringWithString:url];
    if(root != nil){
        [tmp appendString:root];
    }
    if([query count] > 0){
        NSMutableString *delimiter = [NSMutableString stringWithString:@"?"];
        for(NSString *key in [query keyEnumerator]){
            [tmp setString:[[[[tmp stringByAppendingString:delimiter] stringByAppendingString:key] stringByAppendingString:@"="] stringByAppendingString:[query objectForKey:key]]];
            [delimiter setString:@"&"];
        }
    }
    NSLog(@"Url : %@", tmp);
    return tmp;
}

-(void)sendGet
{
    // requestの作成
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self makeUriGet]]];
    
    // Httpで同期通信
    NSData *json_raw_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:nil];
    
    // JSONをNSDictionaryに変換
    // Todo : 配列が飛んでくると死ぬ(*ﾟ∀ﾟ)
    if(json_raw_data != nil){
        NSError *error=nil;
        result = [NSJSONSerialization JSONObjectWithData:json_raw_data options:NSJSONReadingAllowFragments error:&error];
    }else{
        // 通信エラー
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  [NSNumber numberWithBool:YES] , @"error",
                  @"通信エラー" , @"message",
                  nil];
    }
    
}

-(NSDictionary *)getResult
{
    return result;
}

@end
