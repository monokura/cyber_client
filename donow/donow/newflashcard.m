//
//  newflashcard.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "newflashcard.h"
#import "RadioButton.h"
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.labeluser.text = appDelegate.userid;
    self.textf_detail.delegate = self;
    self.textf_flashname.delegate = self;
    
    //ラジオボタン設定
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    RadioButton *rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    rb1.frame = CGRectMake(130,330,22,22);
    rb2.frame = CGRectMake(130,360,22,22);
    rb3.frame = CGRectMake(130,390,22,22);
    
    [self.view addSubview:rb1];
    [self.view addSubview:rb2];
    [self.view addSubview:rb3];
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(160, 330, 60, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"公開";
    [self.view addSubview:label1];
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(160, 360, 200, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"グループ公開";
    [self.view addSubview:label2];
    
    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(160, 390, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"非公開";
    [self.view addSubview:label3];
    [RadioButton addObserverForGroupId:@"first group" observer:self];

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
    //[self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


- (IBAction)backgroundpush:(id)sender {
    [self.view endEditing:YES];
}
//ラジオボタン変更時
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %d in %@",index,groupId);
    //if up     select  then index=0
    //if center select  then index=1
}

@end
