//
//  CustomCell.h
//  donow
//
//  Created by techcamp on 13/09/11.
//
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic)IBOutlet CustomCell *CustomCell;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end
