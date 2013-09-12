//
//  flashcard_setting.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "flashcard_setting.h"

@interface flashcard_setting ()

@end

@implementation flashcard_setting

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
      self.navigationItem.title = @"設定";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)remove_card:(id)sender {
}

//削除した場合の処理
- (IBAction)delete_card:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];//
}

- (IBAction)edit_flashcard:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"edit_flashcard"];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
@end
