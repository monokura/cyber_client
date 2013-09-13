//
//  AppDelegate.h
//  donow
//
//  Created by shirakurakento on 2013/09/06.
//
//

#import <UIKit/UIKit.h>
#import "Word.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *userid;
    NSMutableArray *temp_wordList;
    NSString *filename;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSString *userid;
@property (nonatomic) NSMutableArray *temp_wordList;
@property (nonatomic) NSString *filename;
@end
