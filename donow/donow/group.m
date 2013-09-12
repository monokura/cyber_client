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

- (void)navigatinBarItemMake{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"新規" style:101 target:self action:@selector(leftButtonPush)];
    self.navigationItem.leftBarButtonItem = leftButton;
}


- (void)viewDidLoad
{
    myflashcard = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"グループ一覧";
    [self navigatinBarItemMake];
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
        UITableViewController *viewController = nil;
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"group_information"];
        [self.navigationController pushViewController:viewController animated:YES];
}

-(void)clickButton{
    UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"serch_group"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)leftButtonPush{
    UIViewController *viewController = nil;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newgroup"];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
