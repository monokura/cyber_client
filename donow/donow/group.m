//
//  group.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "group.h"

@interface group ()

@end

@implementation group{
    NSMutableArray *myflashcard;//セル表示用配列
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


- (void)viewDidLoad
{
    //セルに表示するテキストを配列に格納
    myflashcard = [[NSMutableArray alloc] init];      //未初期化
    [myflashcard addObject:@"新規グループ作成"];
    for(int i = 1; i < 4;i++){
        NSString *tmp = @"グループ";
        [myflashcard addObject:[tmp stringByAppendingString:[NSString stringWithFormat:@"%d", i]]];
    }
    
    UIBarButtonItem *btn        =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = btn;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [myflashcard count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // セルに表示する文字を設定
    cell.textLabel.text = [myflashcard objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [myflashcard objectAtIndex:indexPath.row];
    
    if([title isEqualToString:@"新規グループ作成"])
    {
        UIViewController *viewController = nil;
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newgroup"];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        UITableViewController *viewController = nil;
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"group_information"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)clickButton{
    UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"serch_group"];
    
     NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
