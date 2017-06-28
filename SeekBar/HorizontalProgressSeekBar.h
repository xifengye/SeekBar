//
//  HorizontalProgressSeekBar.h
//  SeekBar
//
//  Created by yexifeng on 17/6/27.
//  Copyright © 2017年 yexifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalProgressSeekBar;

@protocol HorizontalProgressSeekBarDelegate <NSObject>

@optional
-(void)onProgressChange:(HorizontalProgressSeekBar*) seekBar progress:(int)progress;
-(void)onPieceProgressChange:(HorizontalProgressSeekBar*) seekBar progress:(int)progress;

@end

@interface HorizontalProgressSeekBar : UIView

-(void)setTextHint:(NSString*)text;
-(int)getProgress;
-(void)setStepProgress:(int)minProgress maxProgress:(int)maxProgress step:(int)step;
-(void)addPiece;
-(void)minusPiece;
@property (nonatomic,weak) id<HorizontalProgressSeekBarDelegate> delegate;
@end
