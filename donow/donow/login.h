//
//  login.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>
@interface login : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *TextBoxId;
@property (weak, nonatomic) IBOutlet UITextField *TextBoxPass;
@property (strong, nonatomic) IBOutlet UIControl *PageOutline;
@property (readwrite)NSString *userid;
- (IBAction)button_login:(UIButton *)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)regist_user:(id)sender;
- (void)saveFile;
- (void)saveFile:(NSDictionary *)data
          toFile:(NSString *)filename;
@end
