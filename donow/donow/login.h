//
//  login.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>

@interface login : UIViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *TextBoxId;
@property (weak, nonatomic) IBOutlet UITextField *TextBoxPass;
- (IBAction)button_login:(UIButton *)sender;
- (IBAction)backgroundTapped:(id)sender;

-(void)keyboardDidShow:(NSNotification *)notification;
-(void)keyboardDidHide:(NSNotification *)notification;
@end
