//
//  LYTestViewController.m
//  DemoList
//
//  Created by luoyan on 2018/1/9.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYTestViewController.h"
#import "Father.h"
#import <objc/runtime.h>

@interface LYTestViewController ()<NSMachPortDelegate>
@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期望线程发送信号的通信端口

@property (nonatomic,copy) NSString *name;
@end

@implementation LYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"www.baidu.com"] applicationActivities:nil];
//    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    // Do any additional setup after loading the view.
    
    Son *son = [Son new];
    Father *father = [Father new];
    
    NSLog(@ "[Father class]: %p", [Father class]); //1. 0x10eb1c218
    NSLog(@ "[father class]: %p", [father class]); //2. 0x10eb1c218
    NSLog(@ "[Son class]: %p,Son=%@", [Son class],[Son class]); //3. 0x10eb1c240
    NSLog(@ "[son class]: %p,son=%@", [son class],[son class]); //4. 0x10eb1c240
    NSLog(@ "[son superclass]: %p", [son superclass]);//5. 0x10eb1c218
    NSLog(@ "[father superclass]: %p", [father superclass]); //6. 0x11023dea8
    NSLog(@ "[NSObject class]: %p", [NSObject class]); //7. 0x11023dea8
    NSLog(@ "[NSObject superclass]: %p", [NSObject superclass]); //8. 0x0
    NSLog(@ "[son isa]: %p", object_getClass(son)); //9. 0x10eb1c240
    NSLog(@ "[[son class] isa]: %p", object_getClass([son class])); //10. 0x10eb1c268
    NSLog(@ "[father isa]: %p", object_getClass(father)); //11. 0x10eb1c218
    NSLog(@ "[[father class] isa]: %p", object_getClass([father class])); //12. 0x10eb1c1f0
    NSLog(@ "[[NSObject class] isa]: %p", object_getClass([NSObject class])); //13. 0x11023de58
    NSLog(@ "[[[NSObject class] isa] superclass]: %p", [(id)object_getClass([NSObject class]) superclass]); //14. 0x11023dea8
    NSLog(@ "[[[Father class] isa] superclass]: %p", [(id)object_getClass([Father class]) superclass]); //15. 0x11023de58
    NSLog(@ "[[[Son class] isa] superclass]: %p", [(id)object_getClass([Son class]) superclass]); //16. 0x10eb1c1f0
    NSLog(@ "[[[NSObject class] isa] isa]: %p", object_getClass(object_getClass([NSObject class]))); //17. 0x11023de58
    NSLog(@ "[[[father class] isa] isa]: %p", object_getClass(object_getClass([father class]))); //18. 0x11023de58
    NSLog(@ "[[[son class] isa] isa]: %p", object_getClass(object_getClass([son class]))); //19. 0x11023de58
    
    NSLog(@ "%d", [(id)[NSObject class] isKindOfClass:[NSObject class]]);
    NSLog(@ "%d", [(id)[NSObject class] isMemberOfClass:[NSObject class]]);
    NSLog(@ "%d", [(id)[Son class] isKindOfClass:[Son class]]);
    NSLog(@ "%d", [(id)[Son class] isMemberOfClass:[Son class]]);
    NSLog(@ "%d", [son isMemberOfClass:[Son class]]);
    NSLog(@ "%d", [son isMemberOfClass:[Father class]]);
    NSLog(@ "%d", [son isKindOfClass:[Father class]]);
    NSLog(@ "%d", [son isKindOfClass:[Son class]]);
    
//    [self runloopTest];
//    [self mutableThreadTest];
//    [self notificationTest];
//    [self exceptionTest];
    NSDictionary *dic = [[NSDictionary alloc] init];
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"change 1");
    [self willChangeValueForKey:@"name"];
    NSLog(@"change 2");
    [self didChangeValueForKey:@"name"];
    NSLog(@"change 4");
    
    NSDictionary *dict = @{
                           @"name" : @"jack",
                           };
    Father *f = [[Father alloc]init]; // p是一个模型对象
    [f setValuesForKeysWithDictionary:dict];
    unsigned int count;
    objc_property_t * result = class_copyPropertyList(object_getClass(f), &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t o_t =  result[i];
        NSString *key = [NSString stringWithFormat:@"%s", property_getName(o_t)];
        NSString *value = [f valueForKey:key];
        NSLog(@"key=%@,value=%@", key,value);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"change 3");
}

- (void)exceptionTest{
    NSArray *tests = @[@"1"];
    [tests objectAtIndex:2];
}

- (void)notificationTest{
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    // 初始化
    self.notifications = [[NSMutableArray alloc] init];
    self.notificationLock = [[NSLock alloc] init];
    
    self.notificationThread = [NSThread currentThread];
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:@"TestNotification" object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:nil userInfo:nil];
        
    });
}

- (void)handleMachMessage:(void *)msg {
    
    [self.notificationLock lock];
    
    while ([self.notifications count]) {
        NSNotification *notification = [self.notifications objectAtIndex:0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    
    if ([NSThread currentThread] != _notificationThread) {
        // Forward the notification to the correct thread.
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        [self.notificationPort sendBeforeDate:[NSDate date]
                                   components:nil
                                         from:nil
                                     reserved:0];
    } else {
        //转发到期望的线程中处理了
        // Process the notification here;
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSLog(@"process notification");
    }
}

- (void)mutableThreadTest{
    NSLog(@"mutableThreadTest 1");
    dispatch_queue_t queue = dispatch_queue_create("11", nil);
    dispatch_sync(queue, ^{
        NSLog(@"mutableThreadTest 2");
    });
    NSLog(@"mutableThreadTest 3");
}

- (void)runloopTest
{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (activity == kCFRunLoopEntry) {
            NSLog(@"entry");
        } else if (activity == kCFRunLoopBeforeTimers) {
            NSLog(@"kCFRunLoopBeforeTimers");
        } else if (activity == kCFRunLoopBeforeSources) {
            NSLog(@"kCFRunLoopBeforeSources");
        } else if (activity == kCFRunLoopBeforeWaiting) {
            NSLog(@"kCFRunLoopBeforeWaiting");
        } else if (activity == kCFRunLoopAfterWaiting) {
            NSLog(@"kCFRunLoopAfterWaiting");
        } else if (activity == kCFRunLoopExit) {
            NSLog(@"kCFRunLoopExit");
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (NSInteger i = 0; i<1000; i++) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"i = %zd",i);
//            });
//        }
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            for (NSInteger i = 0; i<1000; i++) {
                NSLog(@"i = %zd",i);
            }
        }];
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue addOperation:operation];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
