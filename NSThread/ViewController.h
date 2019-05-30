//
//  ViewController.h
//  NSThread
//
//  Created by Civet on 2019/5/27.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//定义线程对象
@property(nonatomic,strong) NSThread *thread1;
@property(nonatomic,strong) NSThread *thread2;
//定义一个计数器
@property(nonatomic,assign) NSInteger counter;
//定义一个线程解锁对象
@property(nonatomic,strong) NSLock *lock;


@end

