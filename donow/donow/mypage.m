///Users/techcamp/cyber_client/donow/donow/mypage.m
//  mypage.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "mypage.h"
#import "newflashcard.h"
#import "CustomCell.h"
#import "HttpRequest.h"

@interface mypage ()

@end

@implementation mypage{
    NSMutableArray *myflashcard;//セル表示用配列
    NSString *filename_;
}
@synthesize filename= filename_;

- (id)init
{
    self = [super initWithNibName:@"STSelectCellViewController" bundle:nil];
    if (self) {
        self.title = @"Select Cell";
   }
    return self;
}

- (void)navigatinBarItemMake{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"新規" style:101 target:self action:@selector(leftButtonPush)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"単語帳一覧";
    [self navigatinBarItemMake];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    // サーバーから単語帳データを持ってくる
    HttpRequest *http = [[HttpRequest alloc] init];
    [http setRoot:@"/searchUser"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [http addKey:@"name" andValue:appDelegate.userid];
    [http sendGet];
    NSDictionary *result = [http getResult];
    NSArray *flashcardArray = [result objectForKey:@"flashcards"];
    [self saveFlashcard:flashcardArray];
    
    //セルに表示するテキストを配列に格納
    myflashcard = [[NSMutableArray alloc] init];
    
    NSArray *flashcards = [self loadFlashcardFile];
    
    for(NSDictionary *dic in flashcards){
        NSLog(@"========%@",[dic objectForKey:@"name"]);
        [myflashcard addObject:[dic objectForKey:@"name"]];
    }
    
    //ツールバー右に検索ボタンを追加
    UIBarButtonItem *btn        =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = btn;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [myflashcard count];
}

- (void)viewWillAppear:(BOOL)animated
{
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.bodyLabel.text = [myflashcard objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath is %@",indexPath);
  UIViewController *viewController = [[UIViewController alloc]init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *flashList = [self loadFlashcardFile];
    NSLog(@"2222 : %@", [flashList description]);
    NSLog(@"2222 : %d", indexPath.row);
    NSLog(@"2222 : %@", [[flashList objectAtIndex:indexPath.row] objectForKey:@"id"]);
    appDelegate.filename = [[flashList objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    NSLog(@"2222 : %@", appDelegate.filename);
    
  viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
  viewController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)leftButtonPush{
    UIViewController *viewController = nil;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newflashcard"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)clickButton{
    UIViewController *viewController = nil;
    
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"choice_flashcard"];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (NSArray *)loadFlashcardFile
{
    // ロードするファイルのパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"flashcard.txt"];
    
    // ファイルマネージャの取得
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在すればロードする
    if([fileManager fileExistsAtPath:path]){
        NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        // 読み込んだ値を表示
        NSMutableArray *arr = [string propertyList];
        return arr;
    }
    
    return [[NSMutableArray alloc] init];
}

-(void)saveFlashcard:(NSArray *)flashcards
{
    NSString *str = [flashcards description];
    // 保存先パス設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"flashcard.txt"];
    
    // ファイルの削除
    NSError* error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    // ファイルに保存
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

@end