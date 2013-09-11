//
//  newflashcard.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>
#import "login.h"

@interface newflashcard : UIViewController<UITextFieldDelegate> 
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationitem;
- (IBAction)to_choice_group:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *grouplabel;
- (IBAction)to_choice_word:(id)sender;
- (IBAction)makeflashcard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *flashcard_name;
@property (weak, nonatomic) IBOutlet UILabel *labeluser;
@property (weak, nonatomic) NSMutableString *labeluserfrom;
@property (weak, nonatomic) IBOutlet UITextField *textf_flashname;
@property (weak, nonatomic) IBOutlet UITextField *textf_detail;
- (IBAction)backgroundpush:(id)sender;

@end
