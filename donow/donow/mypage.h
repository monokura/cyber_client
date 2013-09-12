//
//  mypage.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>

@interface mypage : UITableViewController

-(NSMutableArray *)loadFlashcardFile;

- (void)saveFlashcard:(NSArray *)flashcards;
@end
