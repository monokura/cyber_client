//
//  DataViewController.m
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //ring_view
    //   _ring_view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view2.png"]];           //rootview背景
    //画像リサイズコード///////////////////////////////////
    //UIImage *img = [UIImage imageNamed:@"view.png"];
    //size_t resize_w=215, resize_h=70;
    //UIGraphicsBeginImageContext(CGSizeMake(resize_w, resize_h));
    //[img drawInRect:CGRectMake(0, 0, resize_w, resize_h)];
    //img = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();
    //_ring_view.backgroundColor = [UIColor colorWithPatternImage:img];           //rootview背景
    ////////////////////////////////////////////////////
    
    
    /*
    //rootview///////////////////////////////////
    _ring.view.frame = CGRectMake(0, 0, 30, 30);                   //rootviewサイズ
    _ring.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view.png"]];           //rootview背景
    _ring = [[UIViewController alloc] init];
    [self.view addSubview:_ring.view];                               //rootviewをviewに追加
    /////////////////////////////////////////////
*/
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
