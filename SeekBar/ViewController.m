//
//  ViewController.m
//  SeekBar
//
//  Created by yexifeng on 17/6/27.
//  Copyright © 2017年 yexifeng. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalProgressSeekBar.h"

@interface ViewController ()

@end

@implementation ViewController{
    HorizontalProgressSeekBar* bar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    bar = [[HorizontalProgressSeekBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    bar.delegate = self;
    [bar setStepProgress:0 maxProgress:10 step:2];
    [self.view addSubview:bar];
    
    
    UIButton* addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, 150, 100, 50)];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didAddBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    
    UIButton* minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 100, 50)];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(didMinusBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:minusBtn];
}

-(void)didAddBtnClicked
{
    [bar addPiece];
}

-(void)didMinusBtnClicked
{
    [bar minusPiece];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onProgressChange:(HorizontalProgressSeekBar*) seekBar progress:(int)progress
{
    [seekBar setTextHint:[NSString stringWithFormat:@"%d",progress]];
}

-(void)onPieceProgressChange:(HorizontalProgressSeekBar *)seekBar progress:(int)progress
{
//    [seekBar setTextHint:[NSString stringWithFormat:@"%d",progress]];
}


@end
