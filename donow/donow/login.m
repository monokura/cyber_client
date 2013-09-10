//
//  login.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "login.h"
#import "HttpRequest.h"

@interface login ()
{
    int _defaultTextViewHeight;
}

@end

@implementation login

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
    // Do any additional setup after loading the view from its nib.
    
    self.TextBoxId.delegate = self;
    self.TextBoxPass.delegate = self;
    
    // システム標準の通知センターを取得
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // キーボードが表示されたらkeyboardDidShow:メソッドを実行
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidShow:)
                               name:UIKeyboardDidShowNotification
                             object:nil];
    
    // キーボードが隠れたらkeyboardDidHide:メソッドを実行
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidHide:)
                               name:UIKeyboardDidHideNotification
                             object:nil];
   
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    // 通知情報を取り出す
    NSDictionary *info = [notification userInfo];
    // キーボードサイズを取得
    NSValue *bValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbFrame = [bValue CGRectValue];
    
    // テキストビューの高さをキーボードサイズ分縮小
    CGRect textFrame = self.PageOutline.frame;
    textFrame.size.height = _defaultTextViewHeight - kbFrame.size.height;
    self.PageOutline.frame = textFrame;
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    // テキストビューの高さを元に戻す
    CGRect textFrame = self.PageOutline.frame;
    textFrame.size.height = _defaultTextViewHeight;
    self.PageOutline.frame = textFrame;
}

-(void)viewDidAppear:(BOOL)animated
{
    // テキストビューの初期サイズ
    CGRect textFrame1 = self.PageOutline.frame;
    _defaultTextViewHeight = textFrame1.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)button_login:(UIButton *)sender {
    NSString *id = self.TextBoxId.text;
    NSString *pass = self.TextBoxPass.text;
    
    if([id length] == 0 || [pass length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログイン失敗" message:@"空欄があります" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/login"];
    [http addKey:@"name" andValue:id];
    [http addKey:@"pass" andValue:pass];
    [http sendGet];
    NSDictionary *result = [http getResult];
    
    if([[result objectForKey:@"error"] boolValue]){
        NSString *mes = [result objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログイン失敗" message:mes delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }else{
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)regist_user:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regist_user"];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}



@end
