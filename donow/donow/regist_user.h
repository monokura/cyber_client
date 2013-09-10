//
//  regist_user.h
//  donow
//
//  Created by techcamp on 13/09/10.
//
//

#import <UIKit/UIKit.h>

@interface regist_user : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TextBoxID;
@property (weak, nonatomic) IBOutlet UITextField *TextBoxPass2;
@property (weak, nonatomic) IBOutlet UITextField *TextBoxPass1;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)registerButtonPushed:(id)sender;

@end
