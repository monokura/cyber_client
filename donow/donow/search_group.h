//
//  search_group.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <UIKit/UIKit.h>

@interface search_group : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray *groupArray;
@property (strong,nonatomic) NSMutableArray *filteredgroupArray;
@property (weak, nonatomic) IBOutlet UISearchBar *serchbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
