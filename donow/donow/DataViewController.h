//
//  DataViewController.h
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
//@property (nonatomic, strong) UIViewControrller *ring;
@property (weak, nonatomic) IBOutlet UIView *ring_view;


@end
