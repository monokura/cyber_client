//
//  ModelController.m
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

@interface ModelController()
@property (readonly, strong, nonatomic) NSMutableArray *pageData;
@end
@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    //_pageData = [[NSMutableArray alloc]initWithObjects:@" ",@"improve",@"を向上させる；よくなる",@"relate",@"を関連づける",@"provide",@"を供給する",        @"consider",@"を見なす、考える",@"include",@"を含む",@"concern",@"心配する",@"  ",nil];
    _pageData = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDictionary *fldic  = [self loadFile:appDelegate.filename];
    
    NSArray *arr = [fldic objectForKey:@"words"];
    
    [_pageData addObject:@" "];
    for (NSDictionary *dic in arr) {
        [_pageData addObject:[dic objectForKey:@"eng"]];
        
        [_pageData addObject:[dic objectForKey:@"jap"]];
    }
    [_pageData addObject:@"  "];
    
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
        
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}



- (NSMutableDictionary *)loadFile:(NSString *)filename
{
    NSString *txtFilename = [filename stringByAppendingString:@".txt"];
    // 保存先パス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:txtFilename];
    
    // ファイルマネージャの取得
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在すればロードする
    if([fileManager fileExistsAtPath:path]){
        NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        // 読み込んだ値を表示
        NSMutableDictionary *arr = [string propertyList];
        return arr;
    }
    
    return [[NSMutableDictionary alloc] init];
}


@end
