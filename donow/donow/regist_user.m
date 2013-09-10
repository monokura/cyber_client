//
//  regist_user.m
//  donow
//
//  Created by techcamp on 13/09/10.
//
//

#import "regist_user.h"
#import "HttpRequest.h"

@interface regist_user ()

@end

@implementation regist_user

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
	// Do any additional setup after loading the view.
    
    self.TextBoxID.delegate = self;
    self.TextBoxPass1.delegate = self;
    self.TextBoxPass2.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)registerButtonPushed:(id)sender {
    NSString *id = self.TextBoxID.text;
    NSString *pass1 = self.TextBoxPass1.text;
    NSString *pass2 = self.TextBoxPass2.text;
    
    // 空欄検知
    if([id length] == 0 || [pass1 length] == 0 || [pass2 length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:@"空欄があります" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    // パスワード不一致
    if(![pass1 isEqualToString:pass2]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:@"パスワードが不一致です" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
    // 同期通信
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/register"];
    [http addKey:@"name" andValue:id];
    [http addKey:@"pass" andValue:pass1];
    [http sendGet];
    NSDictionary *result = [http getResult];
    
    if([[result objectForKey:@"error"] boolValue]){
        NSString *mes = [result objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:mes delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }else{
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
@end
