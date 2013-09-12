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

- (void)navigatinBarItemMake{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"新規" style:101 target:self action:@selector(leftButtonPush)];
    self.navigationItem.leftBarButtonItem = leftButton;
}


- (void)viewDidLoad
{
    self.navigationItem.title = @"単語帳一覧";
    [self navigatinBarItemMake];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    //セルに表示するテキストを配列に格納
    myflashcard = [[NSArray alloc]initWithObjects:@"単語帳1",@"単語帳2",@"単語帳3",@"単語帳4",@"単語帳5",@"単語帳6",@"単語帳7",@"単語帳8",@"単語帳9",@"単語帳10",@"単語帳11",@"単語帳12",nil];      //未初期化

    
    //ツールバー右に検索ボタンを追加
    UIBarButtonItem *btn        =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = btn;

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

@end
