//
//  DateStr.m
//  donow
//
//  Created by shirakurakento on 2013/09/12.
//
//

#import "DateStr.h"

@implementation DateStr

// 日時取得（一意キー作成に使用）
+(NSString *)getDate
{
    // 現在日時を取得
    NSDate *now = [NSDate date];
    
    // NsDate→NSString変換用のフォーマッタを作成
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    // 日付から文字列に変換
    NSString *strNow = [outputFormatter stringFromDate:now];
    
    return strNow;
}

@end
