//
//  HorizontalProgressSeekBar.m
//  SeekBar
//
//  Created by yexifeng on 17/6/27.
//  Copyright © 2017年 yexifeng. All rights reserved.
//

#import "HorizontalProgressSeekBar.h"

#define MAX_PROGRESS 100

@implementation HorizontalProgressSeekBar
{
    CGRect progressFgRect;
    CGRect progressBgRect;
    CGSize textSize;
    UIImage* progressBg;
    UIImage* progressFg;
    UIImage* thumbImg;
    UIImage* hintImg;
    int _progress;
    int _pgHeight;
    int offset;
    float fgWidth;
    NSString* _text;
    UIFont* font;
    NSDictionary*attribute;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawProgressBar];
    [self drawThumb];
    [self drawHint];
    [self drawText];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIImage* bgImg = [UIImage imageNamed:@"room_buyin_progress_bg"];
        progressBg = [bgImg stretchableImageWithLeftCapWidth:bgImg.size.width/2 topCapHeight:bgImg.size.height/2];
        
        UIImage* fgImg = [UIImage imageNamed:@"room_buyin_progress"];
        fgWidth = fgImg.size.width;
        progressFg = [fgImg stretchableImageWithLeftCapWidth:fgImg.size.width/2 topCapHeight:fgImg.size.height/2];
        
        thumbImg = [UIImage imageNamed:@"room_buyin_thumb"];
        hintImg = [UIImage imageNamed:@"room_buyin_hint"];
        _pgHeight = (int)(0.62f*thumbImg.size.height);
        
        offset = (hintImg.size.width-thumbImg.size.width) / 2;
        if(offset < 0 ) {
            offset = 0;
        }
        
        int height = thumbImg.size.height+hintImg.size.height;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
        font = [UIFont systemFontOfSize:15.0f];
        NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};

    }
    return self;
}

-(void)setProgress:(int)progress
{
    if(progress<0)
    {
        progress =0;
    }
    if(progress>MAX_PROGRESS)
    {
        progress = MAX_PROGRESS;
    }
    _progress = progress;
    [self setNeedsDisplay];
    if(_delegate && [_delegate respondsToSelector:@selector(onProgressChange:progress:)])
    {
        [_delegate onProgressChange:self progress:_progress];
    }
    NSLog(@"progress=%d",_progress);
}

-(int)getProgress
{
    return _progress;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self onTouchEvent:touches];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self onTouchEvent:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self onTouchEvent:touches];
}

-(void)onTouchEvent:(NSSet<UITouch *> *)touches
{
    UITouch * touch = [touches anyObject];
    //获得当前手指在屏幕上的相对坐标
    //相对于当前视图的坐标
    CGPoint pt = [touch locationInView:self];
    float x = pt.x;
    if(x<CGRectGetMinX(progressBgRect)+thumbImg.size.width/2)
    {
        x = CGRectGetMinX(progressBgRect)+thumbImg.size.width/2;
    }else if(x>CGRectGetMaxX(progressBgRect)-thumbImg.size.width/2)
    {
        x = CGRectGetMaxX(progressBgRect)-thumbImg.size.width/2;
    }
    
    float len = x-CGRectGetMinX(progressBgRect)-thumbImg.size.width/2;
    float thumbImgWidth = thumbImg.size.width;
    int progress = (int)(len/(progressBgRect.size.width-thumbImgWidth)*MAX_PROGRESS);
    [self setProgress:progress];
    
}

-(void)drawProgressBar
{
    [self drawProgressBarBackground];
    [self drawProgressBarForeground];
}

-(void)drawProgressBarBackground
{
    float y = hintImg.size.height+(thumbImg.size.height-_pgHeight)/2;
    progressBgRect = CGRectMake(offset, y, self.frame.size.width-offset*2,progressBg.size.height);
    
    [progressBg drawInRect:progressBgRect];
}

-(void)drawProgressBarForeground
{
    int width = (int) (thumbImg.size.width / 2 + ((float)(progressBgRect.size.width - thumbImg.size.width)) * _progress / MAX_PROGRESS);
    progressFgRect= CGRectMake(CGRectGetMinX(progressBgRect), CGRectGetMinY(progressBgRect), CGRectGetMinX(progressBgRect) + width, progressFg.size.height);
    [progressFg drawInRect:progressFgRect];
}


-(void)drawThumb
{
    float x = CGRectGetMaxX(progressFgRect)-thumbImg.size.width*0.5f-offset;
    float y = self.frame.size.height-thumbImg.size.height;
    [thumbImg drawAtPoint:CGPointMake(x, y)];
}

-(void)drawHint
{
    int x = CGRectGetMaxX(progressFgRect)-hintImg.size.width/2-offset;
    int y = 0;
    [hintImg drawAtPoint:CGPointMake(x, y)];
}

-(void)drawText
{
    if(_text && [_text length]>0)
    {
        float x = CGRectGetMaxX(progressFgRect) - textSize.width/2-offset;
        float y = (hintImg.size.height*0.1f+textSize.height)/2;
      
        [_text drawAtPoint:CGPointMake(x, y) withAttributes:attribute];
    }
}

-(void)setTextHint:(NSString*)text
{
    _text = text;
    textSize = [text sizeWithAttributes:attribute];
    [self setNeedsDisplay];
}


@end
