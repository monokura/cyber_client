//
//  search_group.h
//  donow
//
//  Created by techcamp on 13/09/09.
//
//

#import <UIKit/UIKit.h>

@interface search_group : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *groupArray;
@property (strong,nonatomic) NSMutableArray *filteredgroupArray;
@property (weak, nonatomic) IBOutlet UISearchBar *groupSerchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *serchbar;

@end
