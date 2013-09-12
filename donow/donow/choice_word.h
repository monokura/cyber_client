//
//  choice_word.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <UIKit/UIKit.h>

@interface choice_word : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, UIAlertViewDelegate>
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

- (void)loadFile;
- (void)saveFile;

@end
