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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HorizontalProgressSeekBar* bar = [[HorizontalProgressSeekBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    [self.view addSubview:bar];
    bar.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onProgressChange:(HorizontalProgressSeekBar*) seekBar progress:(int)progress
{
    [seekBar setTextHint:[NSString stringWithFormat:@"%d",progress]];
}


@end
