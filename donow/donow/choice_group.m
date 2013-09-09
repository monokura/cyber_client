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
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"単語選択";//ナビゲーションバー_タイトル

    
    group = [[NSArray alloc]initWithObjects:@"グループ1",@"グループ2",@"グループ3",@"グループ4",@"グループ5",@"グループ6",@"グループ7",@"グループ8",@"グループ9",@"グループ10",@"グループ11",@"グループ12",nil];      //未初期化
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [group count];
    //    return _rows.count;
}

- (void)viewWillAppear:(BOOL)animated
{
    //    [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
}




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
    cell.textLabel.text = [group objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
