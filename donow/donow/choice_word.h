//
//  choice_word.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <UIKit/UIKit.h>

@interface choice_word : UITableViewController{
   //tableにチェックボックスを作成するための変数
@private
    UIImage *nocheckImage_;
    UIImage *checkedImage_;
    NSArray *initialArray;
    NSArray *addArray;
    NSMutableArray *dataSource_;
    ////////////////////////////////////
}

@end
