//
//  ViewController.m
//  NSThread
//
//  Created by Civet on 2019/5/27.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100+80*i, 80, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101 + i;
        if (i == 0) {
            [btn setTitle:@"复位" forState:UIControlStateNormal];
        }
        else if (i == 1){
            [btn setTitle:@"启动线程1" forState:UIControlStateNormal];
        }
        else if ( i == 2){
            [btn setTitle:@"启动线程2" forState:UIControlStateNormal];
        }
        [self.view addSubview:btn];
        _lock = [[NSLock alloc] init];
    }
    
}

- (void)pressBtn:(UIButton *)btn{
    NSLog(@"tag=========%ld",btn.tag);
    if (btn.tag == 101) {
        NSLog(@"按钮1按下");
        //创建一个线程对象
        //P1:线程对象运行函数的拥有者
        //P2:线程处理函数
        //P3:线程参数
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(actNew:) object:nil];
        //启动并且运行线程
        [thread start];
    }
    else if (btn.tag == 102){
        NSLog(@"按钮2按下");
        //创建并且启动线程
        [NSThread detachNewThreadSelector:@selector(actT1) toTarget:self withObject:nil];
    }
    else if (btn.tag == 103){
        _thread2= [[NSThread alloc] initWithTarget:self selector:@selector(actT2) object:nil];
        //启动并且运行线程
        [_thread2 start];    }
}
//P1:线程对象本身
- (void)actNew:(NSThread *)thread{
//    int i = 0;
//    while (i < 10000) {
//        i ++;
//        NSLog(@"T0 = %d",i);
//    }
    _counter = 0;
    NSLog(@"结束循环0");
}

- (void)actT1{
    int i = 0;
    while (true) {
        i ++;
        if (i > 10000) {
            break;
        }
        //加锁,使操作原子化
        [_lock lock];
        _counter++;
        [_lock unlock];
        NSLog(@"c1 = %ld",_counter);
    }
    NSLog(@"c1 final = %ld",_counter);
}
- (void)actT2{
    int i = 0;
    while (true) {
        i ++;
        if (i > 10000) {
            break;
        }
        [_lock lock];
        _counter++;
        [_lock unlock];
         NSLog(@"c2 = %ld",_counter);
    }
    NSLog(@"c2 final = %ld",_counter);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
