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
{
    NSString *userid_;
}
@synthesize userid =userid_;

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

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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
        //共有
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.userid = [result objectForKey:(@"name")];
        
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //ここに処理を記入
    }
}

- (IBAction)regist_user:(id)sender {
    NSString *id = self.TextBoxId.text;
    NSString *pass = self.TextBoxPass.text;
    
    // 空欄検知
    if([id length] == 0 || [pass length] == 0 ){
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:@"空欄があります" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hoge"//タイトル
        message:@"\n"//メッセージ
        delegate:self
        cancelButtonTitle:@"Cancel"
        otherButtonTitles:@"Done", nil];
        CGAffineTransform trans = CGAffineTransformMakeTranslation(0.0, 30.0);//キーボードでアラートが隠れるのを防ぐ
        [alert setTransform:trans];
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
        [alert addSubview:textField];//textField
        [alert show];
        [textField becomeFirstResponder];
        
        [alert show];
        return;
    }
    //3 Doneの処理
    //}
    //4 入力された文字の取得
    //- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)inputText{
    // 入力後の文字列を取得することはできないため、入力前の文字列と入力された文字列をつなげる
    //    NSMutableString *afterInputText = textField.text.mutableCopy;         //afterInputTextに格納
    //    [afterInputText replaceCharactersInRange:range withString:inputText];
    //   return YES;
    //}

    
    // 同期通信
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/register"];
    [http addKey:@"name" andValue:id];
    [http addKey:@"pass" andValue:pass];
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

@end
