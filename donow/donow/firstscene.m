//
//  firstscene.m
//  donow
//
//  Created by techcamp on 13/09/12.
//
//

#import "firstscene.h"

@interface firstscene ()

@end

@implementation firstscene

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //アプリ起動直後にメソッド呼び出し
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myFunction)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];

     }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)myFunction
{
    [NSThread sleepForTimeInterval:1];//待ち時間1秒
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:nil];
}
@end