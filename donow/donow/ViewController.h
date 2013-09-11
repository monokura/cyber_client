//
//  ViewController.h
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) RootViewController *rvc;
@property (nonatomic, strong) UIButton *setting;
@property (nonatomic, strong) UIButton *left_button;
@property (nonatomic, strong) UIButton *right_button;
@property (nonatomic, strong) UILabel *flashcardname;
@property (nonatomic, strong) UIButton *back;

@end
