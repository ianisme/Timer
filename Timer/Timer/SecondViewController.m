//
//  SecondViewController.m
//  Timer
//
//  Created by jiang  hao on 2016/10/27.
//  Copyright © 2016年 jiang  hao. All rights reserved.
//

#import "SecondViewController.h"
#import "NSTimer+ZBBlockSupport.h"

@interface SecondViewController()

@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) CADisplayLink *displayLink;

@end

@implementation SecondViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //强引用  NSRunloop ---> NSTimer ---> self
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(sayHello) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //使用分类的方法,利用block
//    __weak typeof(self)  weakSelf = self;
//    self.timer = [NSTimer zb_timerWithTimeInterval:1 block:^{
//        [weakSelf sayHello];
//    }
//                                           repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //使用iOS10的新方法,看样子iOS10,苹果爸爸给我们封装好了方法,不会再强引用self了
//    if ([UIDevice currentDevice].systemVersion.floatValue == 10.0) {
//        __weak typeof(self)  weakSelf = self;
//        self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [weakSelf sayHello];
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    }
    
}

- (void)sayHello{
    NSLog(@"hello");
}

- (void)dealloc{
    NSLog(@"%@%s",NSStringFromClass([self class]),__func__);
    [self.timer invalidate];
}

- (IBAction)invalidTimer:(UIButton *)sender {
    [self.timer invalidate];
}


@end
