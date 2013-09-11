///Users/techcamp/cyber_client/donow/donow/mypage.m
//  mypage.m
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import "mypage.h"
#import "newflashcard.h"

@interface mypage ()

@end

@implementation mypage{
    NSArray *myflashcard;//セル表示用配列
    int destination;
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
   }
    return self;
}




- (void)viewDidLoad
{
    self.navigationItem.title = @"単語帳一覧";
    //セルに表示するテキストを配列に格納
    myflashcard = [[NSArray alloc]initWithObjects:@"新規作成",@"単語帳1",@"単語帳2",@"単語帳3",@"単語帳4",@"単語帳5",@"単語帳6",@"単語帳7",@"単語帳8",@"単語帳9",@"単語帳10",@"単語帳11",@"単語帳12",nil];      //未初期化
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //配列の要素数だけセルを設定
    return [myflashcard count];
//    return _rows.count;
}

- (void)viewWillAppear:(BOOL)animated
{
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //セルの右側に"＞"をつける
        
    }
    
    cell.textLabel.text = [myflashcard objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [myflashcard objectAtIndex:indexPath.row];
    UIViewController *viewController = nil;
    
    if([title isEqualToString:@"新規作成"])
    {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newflashcard"];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        NSLog(@"%@", viewController);
        [self presentViewController:viewController animated:YES completion:nil];
        //[self.navigationController pushViewController:viewController animated:YES];

    }
}

@end
