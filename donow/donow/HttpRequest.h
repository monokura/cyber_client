//
//  HttpRequest.h
//  HttpTest
//
//  Created by shirakurakento on 2013/09/08.
//  Copyright (c) 2013年 shirakurakento. All rights reserved.
//

#import <Foundation/Foundation.h>

/*===========================
使用方法
 // 同期・GETの通信のみ対応
 // Todo : 非同期通信
 // 1,初期化（urlはソースコードに直書きしてる）
 HttpRequest *http = [[HttpRequest alloc] init];
 // 2,ルート設定
 [http setRoot:@"/forecast/webservice/json/v1"];
 // 3,クエリ設定(クエリがないなら飛ばす)
 [http addKey:@"city" andValue:@"400040"];
 // 4,Getでデータ送信
 GET[http sendGet];
 POST[http sendPost];
 // 5,結果を取得
 // NSDictionary *hoge = [http getResult];
 
=============================*/

@interface HttpRequest : NSObject{
    // URLを設定
    NSString *url;
    // root
    NSMutableString *root;
    // query
    NSMutableDictionary *query;
    // 結果
    NSDictionary *result;
}
-(id)init;
-(void)setRoot:(NSString *)_root;
-(void)addKey:(NSString *)key andValue:(NSString *)value;
-(NSString *)makeUriGet;
-(void)sendGet;
-(void)sendPost;
-(NSString *)makeKeyPost;
-(NSDictionary *)getResult;
@end
