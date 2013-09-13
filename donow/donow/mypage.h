//
//  mypage.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>

@interface mypage : UITableViewController

@property (readwrite)NSString *filename;
-(NSMutableArray *)loadFlashcardFile;
- (void)saveFlashcard:(NSArray *)flashcards;
@end
