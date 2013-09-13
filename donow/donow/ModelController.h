//
//  ModelController.h
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>
//{NSMutableArray *pageData;}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

- (NSMutableDictionary *)loadFile:(NSString *)filename;
@end
