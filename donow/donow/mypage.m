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
        
/*        _rows = [NSMutableArray arrayWithCapacity:100];
        for (int i = 0; i < 100; i++) {
            NSString *title = [NSString stringWithFormat:@"Item %d", i];
            [_rows addObject:title];
 
        }
 */   }
    return self;
}




- (void)viewDidLoad
{
    self.navigationItem.title = @"単語帳一覧";
    //セルに表示するテキストを配列に格納
    myflashcard = [[NSArray alloc]initWithObjects:@"新規作成",@"単語帳1",@"単語帳2",@"単語帳3",@"単語帳4",@"単語帳5",@"単語帳6",@"単語帳7",@"単語帳8",@"単語帳9",@"単語帳10",@"単語帳11",@"単語帳12",nil];      //未初期化
 //   _tableView.dataSource = self;
 //   _tableView.delegate = self;

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
    return [myflashcard count];
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
    cell.textLabel.text = [myflashcard objectAtIndex:indexPath.row];
    
    return cell;
}



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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *title = [_rows objectAtIndex:indexPath.row];
    NSString *title = [myflashcard objectAtIndex:indexPath.row];
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
