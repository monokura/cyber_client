//
//  group_information.m
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import "group_information.h"

@interface group_information ()

@end

@implementation group_information{
    NSMutableArray *user_list;//セル表示用配列
}

- (void)viewDidLoad
{
    self.navigationItem.title = @"単語帳情報";
	
    //セルに表示するテキストを配列に格納
    user_list = [[NSMutableArray alloc] init];      //未初期化
    for(int i = 1; i < 4;i++){
        NSString *tmp = @"ユーザー";
        [user_list addObject:[tmp stringByAppendingString:[NSString stringWithFormat:@"%d", i]]];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [user_list count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // セルに表示する文字を設定
    cell.textLabel.text = [user_list objectAtIndex:indexPath.row];
    
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
