//
//  LYOthersViewController.m
//  DemoList
//
//  Created by luoyan on 2017/6/20.
//  Copyright © 2017年 luoyan. All rights reserved.
//

#import "LYOthersViewController.h"
#import "LYDIYAnimator.h"
#import "LYDIYPopTransition.h"
#import "LYDIYPushTransition.h"

@interface LYOthersViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    UITableView *tableViewList;
    NSArray     *dataArray;
    NSArray     *controllers;
}
@property (nonatomic,strong) NSBlockOperation *operation;
@end

@implementation LYOthersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"其他";
    [self loadSubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self testThread];
}

- (void)testThread
{
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"task1");
//    });
//
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"task2");
//        sleep(3);
//        NSLog(@"task2 finished");
//    });
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"all task finished");
//    });
    if (self.operation && !self.operation.isCancelled) {
        return;
    }
    self.operation = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation *weakOperation = self.operation;
    __block NSInteger count = 0;
    [weakOperation addExecutionBlock:^{
        for (NSInteger i = 0; i<10000; i++) {
            if (weakOperation.isCancelled) {
                return;
            }
            count = i;
            NSLog(@"task1,currentThread = %@,count = %zd",[NSThread currentThread],count);
        }
    }];
    
//    for (NSInteger i = 0; i<10; i++) {
//        [operation addExecutionBlock:^{
//            NSLog(@"task1,currentThread = %@",[NSThread currentThread]);
//        }];
//    }
    
    [self.operation setCompletionBlock:^{
        NSLog(@"task1 all finished");
    }];
    
//    NSBlockOperation *operation2 = [[NSBlockOperation alloc] init];
//    [operation2 addExecutionBlock:^{
//        NSLog(@"task2,currentThread = %@",[NSThread currentThread]);
//    }];
//
//    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"task3,currentThread = %@",[NSThread currentThread]);
//    }];
//
//    for (NSInteger i = 0; i<20; i++) {
//        NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"task4,currentThread = %@",[NSThread currentThread]);
//        }];
//        [operation4 start];
//    }
//
//
//    [operation start];
//    [operation2 start];
//    [operation3 start];
    
    NSOperationQueue *opQueue = [[NSOperationQueue alloc] init];
    opQueue.name = @"other";
    [opQueue addOperation:self.operation];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakOperation cancel];
//    });
//    [opQueue addOperation:operation2];
//    [opQueue addOperation:operation3];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.operation cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubView
{
    dataArray = @[@"手势密码",
                  @"下载demo",
                  @"timer(NSRunLoopCommonModes)",
                  @"runtime那些事",
                  @"MRC模式测试",
                  @"使用动态库",
                  @"编辑日历事件",
                  @"MotionEffect",
                  @"LYTestDemos",
                  @"自定义转场动画",
                  @"评论"];
    
    controllers = @[@"LYGestureCodeViewController",
                    @"DownloadViewController",
                    @"TimerTableViewController",
                    @"RunTimeMessageViewController",
                    @"MRCModeViewController",
                    @"DynamicFrameworkViewController",
                    @"CalendarViewController",
                    @"LYMotionEffectVC",
                    @"LYTestViewController",
                    @"LYDIYTransitionViewController",
                    @"LYCommentViewController"];
    
    
    
    tableViewList = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    tableViewList.backgroundColor = [UIColor whiteColor];
    tableViewList.delegate = self;
    tableViewList.dataSource = self;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoListCell"];
    [self.contentView addSubview:tableViewList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoListCell"];
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcStr = [controllers objectAtIndex:indexPath.row];
    UIViewController *vc = [[NSClassFromString(vcStr) alloc] init];
    vc.title = [dataArray objectAtIndex:indexPath.row];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 1;
    
    CABasicAnimation *tran = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    tran.duration = 1;
    tran.fromValue = [NSNumber numberWithFloat:0];
    tran.toValue = [NSNumber numberWithFloat:M_PI];
    
    //    vc.transitioningDelegate = animator;
    
    //    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    //    [self.navigationController.view.layer addAnimation:tran forKey:@"an"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
@end
