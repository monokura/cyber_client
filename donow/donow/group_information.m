//
//  group_information.m
//  donow
//
//  Created by techcamp on 13/09/12.
//
//

#import "group_information.h"
#import "userlist.h"

@interface group_information ()
@end

@implementation group_information

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)view_user:(id)sender {
    userlist *us = [self.storyboard instantiateViewControllerWithIdentifier:@"userlist"];
    [self.navigationController pushViewController:us animated:YES];
}

- (IBAction)view_flashcardlist:(id)sender {
}

- (IBAction)view_record:(id)sender {
}
@end
