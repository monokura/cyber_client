//
//  newflashcard.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "newflashcard.h"
#import "RadioButton.h"
#import "HttpRequest.h"
#import "DateStr.h"

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
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)to_choice_word:(id)sender {
    UIViewController *viewController = nil;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"choice_word"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)makeflashcard:(id)sender {
    // データ格納
    NSString *name = self.textf_flashname.text;
    NSString *intro = self.textf_detail.text;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *master = appDelegate.userid;
    NSArray *groupArray = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSData *jsonGroupData = [NSJSONSerialization dataWithJSONObject:groupArray options:kNilOptions error:nil];
    NSString *groupStr= [[NSString alloc] initWithData:jsonGroupData encoding:NSUTF8StringEncoding];
    NSNumber *level = [NSNumber numberWithInt:1];
    NSString *levelStr = [level stringValue];
    NSString *date = [DateStr getDate];
    NSMutableArray *words = [NSMutableArray array];
    
    for(Word *w in appDelegate.temp_wordList){
        NSDictionary *word = [NSDictionary dictionaryWithObjectsAndKeys:[w eng],@"eng",[w jap],@"jap", nil];
        [words addObject:word];
    }
    appDelegate.temp_wordList = [[NSMutableArray alloc] init];
    
    NSData *jsonWordData = [NSJSONSerialization dataWithJSONObject:words options:kNilOptions error:nil];
    NSString *wordsStr= [[NSString alloc] initWithData:jsonWordData encoding:NSUTF8StringEncoding];
    NSString *flashcardid = [name stringByAppendingString:date];
    
    // 作成した単語帳をローカルに保存&サーバーに保存
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/createFlashcard"];
    [http addKey:@"name" andValue:name];
    [http addKey:@"intro" andValue:intro];
    [http addKey:@"master" andValue:master];
    [http addKey:@"group" andValue:groupStr];
    [http addKey:@"level" andValue:levelStr];
    [http addKey:@"date" andValue:date];
    [http addKey:@"words" andValue:wordsStr];
    
    [http sendPost];
    
    NSDictionary *result = [http getResult];
    
    if([[result objectForKey:@"error"] boolValue]){
        NSString *mes = [result objectForKey:@"message"];
        NSLog(@"%@", [result objectForKey:mes]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登録失敗" message:mes delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
    // 保存するためのディクショナリ作成
    NSMutableDictionary *file = [NSMutableDictionary dictionary];
    [file setObject:name forKey:@"name"];
    [file setObject:intro forKey:@"intro"];
    [file setObject:flashcardid forKey:@"id"];
    [file setObject:master forKey:@"master"];
    [file setObject:level forKey:@"level"];
    [file setObject:date forKey:@"date"];
    [file setObject:words forKey:@"words"];

    // ローカルにファイルを保存
    [self saveFile:file toFile:flashcardid];
    
    //一つ前の画面へ遷移
    UIViewController *Controller = [[UIViewController alloc] init];
    Controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
    Controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:Controller animated:YES completion:nil];
    
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

- (void)saveFile:(NSDictionary *)data toFile:(NSString *)filename
{
    NSString *txtFilename = [filename stringByAppendingString:@".txt"];
    // 保存先パス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:txtFilename];
    
    // 文字列に変換
    NSString *str = [data description];
    
    // ファイルに保存
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

@end
