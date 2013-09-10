//
//  choice_word.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "choice_word.h"

@interface choice_word ()

@end

@implementation choice_word{
    NSArray *wordlist;//セル表示用配列
    //      IBOutlet  UITableView *_tableView;
}
/*初期コード１/////////////////////////////////////////////
 - (id)initWithStyle:(UITableViewStyle)style
 {
 self = [super initWithStyle:style];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 *//////////////////////////////////////////////////////////



- (id)init
{
    self = [super initWithNibName:@"STSelectCellViewController" bundle:nil];
    if (self) {
        self.title = @"Select Cell";
        
        /*        _rows = [NSMutableArray arrayWithCapacity:100];
         for (int i = 0; i < 100; i++) {
         NSString *title = [NSString stringWithFormat:@"Item %d", i];
         [_rows addObject:title];
         
         }
         */   }
    return self;
}

//チェックボックス用コード(こぴぺ)

- (void)tableFooterViewMake{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(0, 0, 200, 50);
    [addButton setTitle:@"add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonPush) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [view addSubview:addButton];
    
    self.tableView.tableFooterView = view;
//    [view release];
}

- (void)navigatinBarItemMake{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"WhichIsCheckedCell?" style:101 target:self action:@selector(rightButtonPush)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addButtonPush{
    NSLog(@"push");
    
    for (int i = 0; i < [addArray count]; ++i) {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [tmpDic setObject:[addArray objectAtIndex:i] forKey:@"data"];
        [tmpDic setObject:@"NO" forKey:@"checked"];
        [dataSource_ addObject:tmpDic];
//        [tmpDic release];
    }
    NSLog(@"are");
    [self.tableView reloadData];
    
}
- (void)rightButtonPush{
    NSLog(@"doya");
    NSString *resultString = [[NSString alloc] init];
    for (int i = 0; i < [dataSource_ count]; ++i) {
        if ([[[dataSource_ objectAtIndex:i] objectForKey:@"checked"] isEqualToString:@"YES"]) {
            resultString = [resultString stringByAppendingFormat:@"%@,",[[dataSource_ objectAtIndex:i] objectForKey:@"data"]];
        }
    }
    NSLog(@"resultString : %@",resultString);
}
/////////////////////////////////////////////













- (void)viewDidLoad
{
    //セルに表示するテキストを配列に格納
    wordlist = [[NSArray alloc]initWithObjects:@"新規作成",@"単語帳1",@"単語帳2",@"単語帳3",@"単語帳4",@"単語帳5",@"単語帳6",@"単語帳7",@"単語帳8",@"単語帳9",@"単語帳10",@"単語帳11",@"単語帳12",nil];      //未初期化
    self.navigationItem.title = @"単語選択";//ナビゲーションバー_タイトル

  //チェックボックス用コード//////////////////////////////////
    [super viewDidLoad];
    [self tableFooterViewMake];
    [self navigatinBarItemMake];
    nocheckImage_ = [UIImage imageNamed:@"check_off.png"];
    checkedImage_ = [UIImage imageNamed:@"check_on.png"];
    
//    initialArray = [[NSArray alloc] initWithObjects:@"1-1",@"1-2",@"1-3",@"1-4",@"1-5",@"1-6",@"1-7",@"1-8",@"1-9",@"1-10", nil];
    initialArray = [[NSArray alloc] initWithObjects:@"improve",@"relate",@"provide",@"consider",@"include",@"concern",nil];
    
    addArray = [[NSArray alloc] initWithObjects:@"2-1",@"2-2",@"2-3",@"2-4",@"2-5",@"2-6",@"2-7",@"2-8",@"2-9",@"2-10", nil];
    
    dataSource_ = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [initialArray count]; ++i) {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [tmpDic setObject:[initialArray objectAtIndex:i] forKey:@"data"];
        [tmpDic setObject:@"NO" forKey:@"checked"];
        [dataSource_ addObject:tmpDic];
//        [tmpDic release];
    }
    NSLog(@"dataSource : %@",dataSource_);
    /////////////////////////////////////////////////////
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








/*初期コード２///////////////////////////////////////////////
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 #pragma mark - Table view data source
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 #warning Potentially incomplete method implementation.
 // Return the number of sections.
 return 0;
 }
 */////////////////////////////////////////////////////////


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource_ count];
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [wordlist count];
    //    return _rows.count;
}
*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //セルの右側に"＞"をつける
        
    }
    
    // セルに表示する文字を設定
    //   NSString *title = [_rows objectAtIndex:indexPath.row];
    cell.textLabel.text = [wordlist objectAtIndex:indexPath.row];
    
    return cell;
}

*/
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [[dataSource_ objectAtIndex:indexPath.row] objectForKey:@"data"];
    
    if ([[[dataSource_ objectAtIndex:indexPath.row] objectForKey:@"checked"] isEqualToString:@"NO"]) {
        cell.imageView.image = nocheckImage_;
    }else{
        cell.imageView.image = checkedImage_;
    }
    
    return cell;
}



//チェックボックス用コード
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[dataSource_ objectAtIndex:indexPath.row] objectForKey:@"checked"] isEqualToString:@"YES"]) {
        [[dataSource_ objectAtIndex:indexPath.row] setObject:@"NO" forKey:@"checked"];
        [self.tableView reloadData];
    }else{
        [[dataSource_ objectAtIndex:indexPath.row] setObject:@"YES" forKey:@"checked"];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
///////////////////////////////////////////////////////////


/*初期コード３/////////////////////////////////////////////
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 *//////////////////////////////////////////////////////

/*初期コード4////////////////////////////////////////////
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */////////////////////////////////////////////////////

/*初期コード５//////////////////////////////////////////
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */////////////////////////////////////////////////////

/*初期コード６//////////////////////////////////////////
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */////////////////////////////////////////////////////




#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *title = [_rows objectAtIndex:indexPath.row];
    NSString *title = [wordlist objectAtIndex:indexPath.row];
    UIViewController *viewController = nil;
    
    if([title isEqualToString:@"新規作成"])
    {
        
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newflashcard"];
        //UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newflashcard"];
        //[self presentViewController:viewController animated:YES completion:nil];
        //[self.navigationController pushViewController:viewController animated:YES];
        
    }else{
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"flashcard"];
        //UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"flashcard"];
        //[self presentViewController:viewController animated:YES completion:nil];
        
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.

 }
*/
@end
