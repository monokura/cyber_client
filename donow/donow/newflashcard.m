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
    
    // テストデータ
    NSString *name = @"単語帳1";
    NSString *intro = @"単語帳1の説明";
    NSString *master = @"userid";
    NSArray *groopArray = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSData *jsonGroopData = [NSJSONSerialization dataWithJSONObject:groopArray options:kNilOptions error:nil];
    NSString *groopStr= [[NSString alloc] initWithData:jsonGroopData encoding:NSUTF8StringEncoding];
    NSNumber *level = [NSNumber numberWithInt:1];
    NSString *levelStr = [level stringValue];
    NSString *date = [DateStr getDate];
    NSMutableArray *words = [NSMutableArray array];
    NSDictionary *word1 = [NSDictionary dictionaryWithObjectsAndKeys:@"improve",@"eng",@"を向上させる；よくなる",@"jap",nil];
    NSDictionary *word2 = [NSDictionary dictionaryWithObjectsAndKeys:@"relate",@"eng",@"を関連づける",@"jap",nil];
    NSDictionary *word3 = [NSDictionary dictionaryWithObjectsAndKeys:@"provide",@"eng",@"を供給する",@"jap",nil];
    NSDictionary *word4 = [NSDictionary dictionaryWithObjectsAndKeys:@"consider",@"eng",@"を見なす、考える",@"jap",nil];
    NSDictionary *word5 = [NSDictionary dictionaryWithObjectsAndKeys:@"include",@"eng",@"を含む",@"jap",nil];
    NSDictionary *word6 = [NSDictionary dictionaryWithObjectsAndKeys:@"concern",@"eng",@"心配する",@"jap",nil];
    [words addObject:word1];
    [words addObject:word2];
    [words addObject:word3];
    [words addObject:word4];
    [words addObject:word5];
    [words addObject:word6];
    NSData *jsonWordData = [NSJSONSerialization dataWithJSONObject:words options:kNilOptions error:nil];
    NSString *wordsStr= [[NSString alloc] initWithData:jsonWordData encoding:NSUTF8StringEncoding];
    
    // 作成した単語帳をローカルに保存&サーバーに保存
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/createFlashcard"];
    [http addKey:@"name" andValue:name];
    [http addKey:@"intro" andValue:intro];
    [http addKey:@"master" andValue:master];
    [http addKey:@"groop" andValue:groopStr];
    [http addKey:@"level" andValue:levelStr];
    [http addKey:@"date" andValue:date];
    [http addKey:@"words" andValue:wordsStr];
    
    [http sendPost];
    
    NSDictionary *result = [http getResult];
    
    if([[result objectForKey:@"error"] boolValue]){
        NSLog(@"通信エラー？");
        return;
    }
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage_group"];
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
