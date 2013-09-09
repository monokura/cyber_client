//
//  newflashcard.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "newflashcard.h"
@interface newflashcard ()

@end

@implementation newflashcard
@synthesize grouplabel;
@synthesize flashcard_name;


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
 //   self.navigationController.toolbar.tintColor
 //   = [UIColor colorWithRed:1 green:0 blue:0.50196081399917603 alpha:1];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)to_choice_group:(id)sender {
    UIViewController *viewController = nil;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"choice_group"];
    //UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"flashcard"];
    //[self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}
- (IBAction)to_choice_word:(id)sender {
    UIViewController *viewController = nil;
    
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"choice_word"];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
    
}

- (IBAction)makeflashcard:(id)sender {
    UIViewController *viewController = nil;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
    [self presentViewController:viewController animated:YES completion:nil];
    
    
}
@end
