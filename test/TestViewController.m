//
//  TestViewController.m
//  test
//
//  Created by Apple on 2018/9/12.
//  Copyright © 2018年 LiveStar. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+Frame.h"
@interface TestViewController ()
{
    CGRect _showRect;
    float MaxHeight;
}
@property(assign, nonatomic) BOOL isMoving;
@property(strong, nonatomic) UIImageView *smallView;
@property(assign, nonatomic) BOOL isBegin;
@property(strong, nonatomic) UIView *bgView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _smallView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _smallView.image = [UIImage imageNamed:@"login_main_bg"];
    
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_bgView];
    [self.view addSubview:_smallView];
    
    MaxHeight = [UIScreen mainScreen].bounds.size.height;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint current = [touch locationInView:self.view];
    
    CALayer *touchedLayer = [self.view.layer hitTest:current];
    
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
    
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGPoint center = self.smallView.center;
    
    CGPoint offset = CGPointMake(current.x - previous.x, current.y - previous.y);
    float height = current.y - self.view.nim_centerY;
    if (offset.y <= 0){
        if (!_isBegin){
            self.smallView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
            if (height > 0){
                self.smallView.nim_size = CGSizeMake(_smallView.nim_width * (self.view.nim_height - height)/_smallView.nim_height, self.view.nim_height - height);
                self.bgView.alpha = (MaxHeight - height) / MaxHeight;
            }
        }
    }else{
        _isBegin = false;
        if (height > 0){
            self.smallView.nim_size = CGSizeMake(_smallView.nim_width * (self.view.nim_height - height)/_smallView.nim_height, self.view.nim_height - height);
            self.bgView.alpha = (MaxHeight - height) / MaxHeight;
        }
        self.smallView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
    }
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self.view];
    float height = current.y - self.view.nim_centerY;
    if (height > 50){
        [self dismiss];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.smallView.frame = self.view.bounds;
        }];
    }
    self.isMoving = NO;
    _isBegin = true;
    
}
-(void)show:(UIView *)v{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [v convertRect:v.bounds toView:window];
    _smallView.frame = rect;
    _showRect = rect;
    [UIView animateWithDuration:0.3 animations:^{
        self.smallView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.smallView.frame = self->_showRect;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
