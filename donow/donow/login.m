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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackboard.png"]];
    backgroundImage.frame = CGRectMake(0, 0, 480, 480);
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    self.TextBoxId.delegate = self;
    self.TextBoxPass.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    // 同期通信
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/login"];
    [http addKey:@"name" andValue:id];
    [http addKey:@"pass" andValue:pass];
    [http sendGet];
    NSDictionary *result = [http getResult];
    
    // 通信結果で分岐
    if([[result objectForKey:@"error"] boolValue]){
        NSString *mes = [result objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログイン失敗" message:mes delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }else{
        //共有
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.userid = [result objectForKey:(@"name")];
        
        [self saveFile];
        
        // 同期通信
//        HttpRequest *http = [[HttpRequest alloc] init];
//        [http setRoot:@"/updateData"];
//        [http addKey:@"name" andValue:id];
//        [http sendGet];
//        NSDictionary *res = [http getResult];
//        NSArray *dataArray = [res objectForKey:@"data"];
//        NSLog(@"----%@",[dataArray description]);
//        
//        for(NSDictionary *dic in dataArray){
//            // 保存するためのディクショナリ作成
//            NSMutableDictionary *file = [NSMutableDictionary dictionary];
//            [file setObject:[dic objectForKey:@"name"] forKey:@"name"];
//            [file setObject:[dic objectForKey:@"intro"] forKey:@"intro"];
//            [file setObject:[dic objectForKey:@"id"] forKey:@"id"];
//            [file setObject:[dic objectForKey:@"master"] forKey:@"master"];
//            [file setObject:[dic objectForKey:@"level"] forKey:@"level"];
//            [file setObject:[dic objectForKey:@"update"] forKey:@"date"];
//            [file setObject:[dic objectForKey:@"words"] forKey:@"words"];
//             // ローカルにファイルを保存
//             [self saveFile:file toFile:[dic objectForKey:@"id"]];
//        }
        
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:@"空欄があります" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        return;
    }

    
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
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.userid = [result objectForKey:(@"name")];
        
        [self saveFile];
        
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}


- (void)saveFile
{
    // 保存先パス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"dictionary.txt"];
    
    // Http通信
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/searchWord"];
    [http addKey:@"word" andValue:@""];
    [http sendGet];
    NSDictionary *result = [http getResult];
    NSString *str = [result description];
    
    // ファイルに保存
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}


- (void)saveFile:(NSDictionary *)data toFile:(NSString *)filename
{
    NSString *txtFilename = [filename stringByAppendingString:@".txt"];
    // 保存先パス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:txtFilename];
    
    // 文字列に変換
    NSString *str = [data description];
    
    // ファイルの削除
    NSError* error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    // ファイルに保存
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

@end
