//
//  LSImageView.m
//  test
//
//  Created by Apple on 2018/9/27.
//  Copyright © 2018年 LiveStar. All rights reserved.
//

#import "LSImageView.h"
#import "UIView+Frame.h"
@interface LSImageView(){
    CGRect _showRect;
    float MaxHeight;
}

@property(assign, nonatomic) BOOL isMoving;
@property(strong, nonatomic) UIImageView *smallView;
@property(assign, nonatomic) BOOL isBegin;
@property(strong, nonatomic) UIView *bgView;
@end
@implementation LSImageView

-(instancetype)init{
    
    if (self == [super init]){
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        _smallView = [[UIImageView alloc] initWithFrame:self.bounds];
        _smallView.image = [UIImage imageNamed:@"login_main_bg"];
        
        self.bgView = [[UIView alloc] initWithFrame:self.bounds];
        self.bgView.backgroundColor = [UIColor blackColor];
        [self addSubview:_bgView];
        [self addSubview:_smallView];
        
        MaxHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint current = [touch locationInView:self];
    
    CALayer *touchedLayer = [self.layer hitTest:current];
    
    if(touchedLayer == self.smallView.layer){
        self.isMoving = YES;
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if(!self.isMoving){
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.smallView.center;
    
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
    float height = current.y - self.nim_centerY;
    if (offset.y <= 0){
        if (!_isBegin){
            self.smallView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
            if (height > 0){
                self.smallView.nim_size = CGSizeMake(_smallView.nim_width * (self.nim_height - height)/_smallView.nim_height, self.nim_height - height);
                self.bgView.alpha = (MaxHeight - height) / MaxHeight;
            }
        }
    }else{
        _isBegin = false;
        if (height > 0){
            self.smallView.nim_size = CGSizeMake(_smallView.nim_width * (self.nim_height - height)/_smallView.nim_height, self.nim_height - height);
            self.bgView.alpha = (MaxHeight - height) / MaxHeight;
        }
        self.smallView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
    }
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    float height = current.y - self.nim_centerY;
    if (height > 50){
        [self dismiss];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.smallView.frame = self.bounds;
        }];
    }
    self.isMoving = NO;
    _isBegin = true;
    
}
-(void)show:(UIView *)v{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [v convertRect:v.bounds toView:window];
    [window addSubview:self];
    _smallView.frame = rect;
    _showRect = rect;
    [UIView animateWithDuration:0.3 animations:^{
        self.smallView.frame = self.bounds;
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.smallView.frame = self->_showRect;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
