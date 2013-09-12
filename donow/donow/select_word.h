////
////  select_word.h
////  donow
////
////  Created by techcamp on 13/09/12.
////
////
//
//#import <UIKit/UIKit.h>
//
//@interface select_word : UIViewController
//{
//NSMutableArray *datagroupSource_;
//NSArray *initialArray;
//UIImage *nocheckImage_;
//UIImage *checkedImage_;
//}
//@end
//
//  choice_word.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <UIKit/UIKit.h>
@interface select_word : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UIAlertViewDelegate,UITableViewDelegate>
{
    //tableにチェックボックスを作成するための変数
@private
    UIImage *nocheckImage_;
    UIImage *checkedImage_;
    NSMutableArray *wordList;
    NSMutableArray *filteredWordList;
    ////////////////////////////////////
}
@property (readwrite)NSMutableArray *temp_wordList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

- (void)loadFile;
- (void)saveFile;

@end
