//
//  ViewController.m
//  test
//
//  Created by Apple on 2018/8/29.
//  Copyright © 2018年 LiveStar. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "UIView+Frame.h"
#import "LSImageView.h"
@interface ViewController (){
    LSImageView *imgView;
}
@property(assign, nonatomic) BOOL isMoving;
@property(strong, nonatomic) UIImageView *smallView;
@property(strong, nonatomic) UIImageView *bigView;
@property(assign, nonatomic) BOOL isBegin;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _smallView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    _smallView.image = [UIImage imageNamed:@"login_main_bg"];
    _smallView.contentMode = UIViewContentModeCenter;
    _smallView.layer.masksToBounds = YES;
    _smallView.userInteractionEnabled = YES;
    
    _bigView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, 100, 100)];
    _bigView.image = [UIImage imageNamed:@"login_main_bg"];
    _bigView.contentMode = UIViewContentModeCenter;
    _bigView.layer.masksToBounds = YES;
    _bigView.userInteractionEnabled = YES;
    
    [self.view addSubview:_smallView];
    [self.view addSubview:_bigView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)];
    [_smallView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView)];
    [_bigView addGestureRecognizer:tap1];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, _smallView.frame.size.width, _smallView.frame.size.height);
    _isBegin = true;

    imgView = [[LSImageView alloc] init];
   
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)showImage{
    TestViewController *test = [[TestViewController alloc] init];
    test.modalPresentationStyle = UIModalPresentationOverCurrentContext;//具体意思参考https://blog.csdn.net/tianweitao/article/details/80314598
    test.definesPresentationContext = YES;//为了使present的VC和当前VC在同一层级
    [self.navigationController presentViewController:test animated:NO completion:^{
        [test show:self.smallView];
    }];
}
-(void)showImageView{
     [imgView show:_bigView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
