//
//  flashcard.h
//  donow
//
//  Created by techcamp on 13/09/07.
//
//

#import <UIKit/UIKit.h>
//#import "MPFoldEnumerations.h"
//#import "MPFlipEnumerations.h"
@interface flashcard : UIViewController
@property (weak, nonatomic) IBOutlet UIView *card_before;
@property (weak, nonatomic) IBOutlet UIView *card_after;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)changebuttorn:(id)sender;

@end
