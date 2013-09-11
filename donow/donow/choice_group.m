//
//  choice_group.m
//  donow
//
//  Created by techcamp on 13/09/08.
//
//

#import "choice_group.h"

@interface choice_group ()

@end

@implementation choice_group{
 NSArray *group;//セル表示用配列
}
/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)navigatinBarItemMake{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:101 target:self action:@selector(rightButtonPush)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navigatinBarItemMake];
    nocheckImage_ = [UIImage imageNamed:@"check_off.png"];
    checkedImage_ = [UIImage imageNamed:@"check_on.png"];
    
    self.navigationItem.title = @"グループ選択";//ナビゲーションバー_タイトル
    initialArray = [[NSArray alloc] initWithObjects:@"グループ1",@"グループ2",@"グループ3",@"グループ4",@"グループ5",@"グループ6",@"グループ7",@"グループ8",@"グループ9",@"グループ10",@"グループ11",@"グループ12",nil];
    datagroupSource_ = [[NSMutableArray alloc] init];
    for (int i = 0; i < [initialArray count]; ++i) {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
        [tmpDic setObject:[initialArray objectAtIndex:i] forKey:@"data"];
        [tmpDic setObject:@"NO" forKey:@"checked"];
        [datagroupSource_ addObject:tmpDic];
        //        [tmpDic release];
    }
    
}


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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datagroupSource_ count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //セルの右側に"＞"をつける
    }
    
    // セルに表示する文字を設定
    //   NSString *title = [_rows objectAtIndex:indexPath.row];
    cell.textLabel.text = [[datagroupSource_ objectAtIndex:indexPath.row] objectForKey:@"data"];
    if ([[[datagroupSource_ objectAtIndex:indexPath.row] objectForKey:@"checked"] isEqualToString:@"NO"]) {
        cell.imageView.image = nocheckImage_;
    }else{
        cell.imageView.image = checkedImage_;
    }

    return cell;
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[datagroupSource_ objectAtIndex:indexPath.row] objectForKey:@"checked"] isEqualToString:@"YES"]) {
        [[datagroupSource_ objectAtIndex:indexPath.row] setObject:@"NO" forKey:@"checked"];
        [self.tableView reloadData];
    }else{
        [[datagroupSource_ objectAtIndex:indexPath.row] setObject:@"YES" forKey:@"checked"];
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
//完了ボタン後通信
-(void)rightButtonPush
{
    for (int i = 0; i < [datagroupSource_ count]; ++i) {
        if ([[[datagroupSource_ objectAtIndex:i] objectForKey:@"checked"] isEqualToString:@"YES"]) {
            //チェックが入ってるセルに関するコードはここ
            //サーバー&ローカル通信
            NSLog(@"check");
        }
    }
    
    
    NSLog(@"finish rightButtonPush");
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
