//
//  choice_word.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "choice_word.h"
#import "Word.h"

@interface choice_word ()

@end

@implementation choice_word{
    NSArray *wordlist;//セル表示用配列
}


- (id)init
{
    self = [super initWithNibName:@"STSelectCellViewController" bundle:nil];
    if (self) {
        self.title = @"Select Cell";
   
    }
    return self;
}

//チェックボックス用コード

- (void)navigatinBarItemMake{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:101 target:self action:@selector(rightButtonPush)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


- (void)rightButtonPush{
    NSLog(@"doya");
    
}
/////////////////////////////////////////////


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.navigationItem.title = @"単語選択";//ナビゲーションバー_タイトル
    [self navigatinBarItemMake];
    nocheckImage_ = [UIImage imageNamed:@"check_off.png"];
    checkedImage_ = [UIImage imageNamed:@"check_on.png"];
    
    // 1900語ロード
    [self loadFile];
    filteredWordList = [NSMutableArray arrayWithCapacity:[wordList count]];
    
    // Reload the table
    [[self tableView] reloadData];
}

//チェックボックス用コード３
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
//////////////////////////////////////////////////////

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
    if ([word getCheck]) {
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.eng contains[c] %@",searchText];
    NSArray *tempArray = [wordList filteredArrayUsingPredicate:predicate];
    
//    if(![scope isEqualToString:@"All"]) {
//        // Further filter the array with the scope
//        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
//        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
//    }
//    
    filteredWordList = [NSMutableArray arrayWithArray:tempArray];
    
}

//チェックボックス用コード
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *w = [wordList objectAtIndex:indexPath.row];
    BOOL check = YES;
    if ([w getCheck]) {
        check = NO;
    }
    
    [[wordList objectAtIndex:indexPath.row] setCheck:check];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
//////////////////////////////////////////////////////

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
        for(NSDictionary *dic in wordArray){
            NSString *eng = [dic objectForKey:@"eng"];
            NSString *jap = [dic objectForKey:@"jap"];
            
            // 配列に追加
            [wordList addObject:[Word setEng:eng andJap:jap]];
        }
    }else{
        // ファイルがないときの処理
        NSLog(@"file is not found");
    }
}

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

@end
