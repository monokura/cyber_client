////
////  select_word.m
////  donow
////
////  Created by techcamp on 13/09/12.
////
////
//
//#import "select_word.h"
//
//@interface select_word ()
//
//@end
//
//@implementation select_word
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
//
//  choice_word.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "select_word.h"
#import "HttpRequest.h"
#import "Word.h"

@interface select_word ()

@end

@implementation select_word{
    NSArray *wordlist;//セル表示用配列
    NSMutableArray *temp_filterWordList_;
    
}
@synthesize temp_wordList = temp_wordList_;
/////////////////////////////////////////////

- (id)init
{
    self = [super initWithNibName:@"STSelectCellViewController" bundle:nil];
    if (self) {
        self.title = @"Select Cell";
    }
    return self;
}


- (void)viewDidLoad
{
    
    self.navigationItem.title = @"単語選択";//ナビゲーションバー_タイトル
    [super viewDidLoad];
    
    [self navigatinBarItemMake];
    nocheckImage_ = [UIImage imageNamed:@"check_off.png"];
    checkedImage_ = [UIImage imageNamed:@"check_on.png"];
    
    // 1900語ロード
    [self loadFile];
    filteredWordList = [NSMutableArray arrayWithCapacity:[wordList count]];
    
    // Reload the table
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

// ============ チェックボックス用コード ===========

- (void)navigatinBarItemMake{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:101 target:self action:@selector(rightButtonPush)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


- (void)rightButtonPush{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.temp_wordList = nil;
    appDelegate.temp_wordList = [[NSMutableArray alloc] init];
    
    for(Word *word in wordList){
        if([word getCheck] == 1){
            Word *w = [[Word alloc] init];
            [w setEng: [word eng]];
            [w setJap: [word jap]];
            [w setCheck:YES];
            [w setIndex:[word getIndex]];
            [appDelegate.temp_wordList addObject:w];
        }
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

// ============== テーブルビュー関連 ==============

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return [filteredWordList count];
    }else{
        return [wordList count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セル設定
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // セルに単語をセット
    Word *word = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        word = [filteredWordList objectAtIndex:indexPath.row];
    }else{
        word = [wordList objectAtIndex:indexPath.row];
    }
    [[cell textLabel] setText:[word eng]];
    
    // チェックボックスをセット
    if ([word getCheck] == YES) {
        cell.imageView.image = checkedImage_;
    }else{
        cell.imageView.image = nocheckImage_;
    }
    
    return cell;
}

// フィルタリング
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[filteredWordList removeAllObjects];
    
	// Filter the array using NSPredicate
    // 部分一致
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.eng contains[c] %@",searchText];
    // 前方一致
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.eng beginsWith[c] %@",searchText];
    
    NSArray *tempArray = [wordList filteredArrayUsingPredicate:predicate];
    
    // チェック済みのみ表示
    /*
     if( "チェック済みボタン" ) {
     // Further filter the array with the scope
     NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.check == 1",scope];
     tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
     }
     */
    
    filteredWordList = [NSMutableArray arrayWithArray:tempArray];
    
}

//チェックボックス用コード
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.searchDisplayController.searchResultsTableView){
        // フィルタされた単語をチェック
        Word *fw = [filteredWordList objectAtIndex:indexPath.row];
        BOOL check = YES;
        if ([fw getCheck] == YES) {
            check = NO;
        }
        [[filteredWordList objectAtIndex:indexPath.row] setCheck:check];
        
        // 単語から元の配列でのindexを取得し元の配列もチェック
        [[wordList objectAtIndex:[fw getIndex]] setCheck:check];
        
        [tableView reloadData];
    }else{
        Word *w = [wordList objectAtIndex:indexPath.row];
        BOOL check = YES;
        if ([w getCheck] == YES) {
            check = NO;
        }
        
        [[wordList objectAtIndex:indexPath.row] setCheck:check];
    }
    
    [self.tableView reloadData];
}



//////////////////////////////////////////////////////


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

// =================== File IO =====================

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

- (void)loadFile
{
    // 初期化
    wordList = [NSMutableArray array];
    // ロードするファイルのパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"dictionary.txt"];
    
    // ファイルマネージャの取得
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在すればロードする
    if([fileManager fileExistsAtPath:path]){
        NSString *filestr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        // 読み込んだ値を表示
        NSDictionary *filedic = [filestr propertyList];
        NSArray *wordArray = [filedic objectForKey:@"word"];
        int counter = 0;
        for(NSDictionary *dic in wordArray){
            NSString *eng = [dic objectForKey:@"eng"];
            NSString *jap = [dic objectForKey:@"jap"];
            
            // 配列に追加
            [wordList addObject:[Word setEng:eng andJap:jap andIndex:counter]];
            counter++;
        }
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        if([appDelegate.temp_wordList count] != 0){
            for(Word *w in appDelegate.temp_wordList){
                [[wordList objectAtIndex:[w getIndex]] setCheck:YES];
            }
        }
    }else{
        // ファイルがないときの処理
        NSLog(@"file is not found");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"辞書データが見つかりません"//タイトル
                                                        message:@"ファイルをダウンロードしますか？"//メッセージ
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1) {
        // 押されたのは2番目のボタン（OKと表示されたボタン）
        [self saveFile];
        [self loadFile];
    }
}

@end
