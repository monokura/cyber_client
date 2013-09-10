//
//  ViewController.m
//  pageview3
//
//  Created by techcamp on 13/09/08.
//  Copyright (c) 2013年 techcamp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];               //view背景
    UIImage *check_off = [UIImage imageNamed:@"check_off.png"];     //ボタン画像生成
    UIImage *check_on = [UIImage imageNamed:@"check_on.png"];       //ボタン画像生成
    
    //rootview///////////////////////////////////
    _rvc.view.frame = CGRectMake(0, 0, 480, 240);                   //rootviewサイズ
    _rvc.view.backgroundColor = [UIColor whiteColor];               //rootview背景
    _rvc = [[RootViewController alloc] init];
    [self.view addSubview:_rvc.view];                               //rootviewをviewに追加
    /////////////////////////////////////////////

    //setting_button/////////////////////////////
    _setting =  [UIButton buttonWithType:UIButtonTypeCustom];
    _setting.frame = CGRectMake(430, 250, 50, 50);                  //ボタン位置設定
    UIImage *img = [UIImage imageNamed:@"check_off.png"];           //ボタン画像生成
    [_setting setBackgroundImage:img forState:UIControlStateNormal];//画像セット
    //[_setting setTitle:@"設定" forState:UIControlStateNormal];     //文字入力
    //[_setting sizeToFit];                                         //サイズ自動調整関数
    [_setting addTarget:self
               action:@selector(button_Tapped:)
       forControlEvents:UIControlEventTouchUpInside];               // ボタンタップ時呼び出しメソッド(button_Tapped)
    [self.view addSubview:_setting];                                // settingをviewに追加
    ///////////////////////////////////////////////
    
    //left_button/////////////////////////////
    _left_button =  [UIButton buttonWithType:UIButtonTypeCustom];
    _left_button.frame = CGRectMake(90, 180, 50, 50);               //ボタン位置設定
    [_left_button setBackgroundImage:check_off
                            forState:UIControlStateNormal];         //画像セット
    [_left_button sizeToFit];                                       //サイズ自動調整関数
    [_left_button addTarget:self
                 action:@selector(button_Tapped:)
       forControlEvents:UIControlEventTouchUpInside];               // ボタンタップ時呼び出しメソッド(button_Tapped)
    [self.view addSubview:_left_button];                            // settingをviewに追加
    [self.view sendSubviewToBack:_left_button];                     //ボタンを最背面に表示
    ///////////////////////////////////////////////
    
    //right_button/////////////////////////////
    _right_button =  [UIButton buttonWithType:UIButtonTypeCustom];
    _right_button.frame = CGRectMake(320, 180, 50, 50);               //ボタン位置設定
    [_right_button setBackgroundImage:check_off
                            forState:UIControlStateNormal];         //画像セット
    [_right_button sizeToFit];                                       //サイズ自動調整関数
    [_right_button addTarget:self
                     action:@selector(button_Tapped:)
           forControlEvents:UIControlEventTouchUpInside];               // ボタンタップ時呼び出しメソッド(button_Tapped)
    [self.view addSubview:_right_button];                            // settingをviewに追加
    [self.view sendSubviewToBack:_right_button];                     //ボタンを最背面に表示
    ///////////////////////////////////////////////
    
    
    //flashcardname/////////////////////////////
    _flashcardname =  [[UILabel alloc] init];
    _flashcardname.frame = CGRectMake(210, 30, 200, 50);               //ボタン位置設定
    _flashcardname.contentMode=UIViewContentModeCenter;
    _flashcardname.text = @"単語帳";
    [self.view addSubview:_flashcardname];                            // settingをviewに追加
    [self.view sendSubviewToBack:_flashcardname];                     //ボタンを最背面に表示
    /* [_right_button setBackgroundImage:check_off
                             forState:UIControlStateNormal];         //画像セット
    [_right_button sizeToFit];                                       //サイズ自動調整関数
    [_right_button addTarget:self
                      action:@selector(button_Tapped:)
            forControlEvents:UIControlEventTouchUpInside];               // ボタンタップ時呼び出しメソッド(button_Tapped)
    [self.view addSubview:_right_button];                            // settingをviewに追加
    [self.view sendSubviewToBack:_right_button];                     //ボタンを最背面に表示
   */ ///////////////////////////////////////////////
    
    //setting_button/////////////////////////////
    _setting =  [UIButton buttonWithType:UIButtonTypeCustom];
    _setting.frame = CGRectMake(0, 0, 80, 50);                  //ボタン位置設定
  //  UIImage *img = [UIImage imageNamed:@"check_off.png"];           //ボタン画像生成
    [_setting setBackgroundImage:img forState:UIControlStateNormal];//画像セット
    [_setting setTitle:@"戻る" forState:UIControlStateNormal];     //文字入力
    //[_setting sizeToFit];                                         //サイズ自動調整関数
    [_setting addTarget:self
                 action:@selector(button_Tapped1:)
       forControlEvents:UIControlEventTouchUpInside];               // ボタンタップ時呼び出しメソッド(button_Tapped)
    [self.view addSubview:_setting];                                // settingをviewに追加
    ///////////////////////////////////////////////
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
