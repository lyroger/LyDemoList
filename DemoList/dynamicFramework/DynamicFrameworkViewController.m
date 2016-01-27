//
//  DynamicFrameworkViewController.m
//  DemoList
//
//  Created by luoyan on 16/1/19.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "DynamicFrameworkViewController.h"
#import "dlfcn.h"
#import "SSZipArchive.h"

@interface DynamicFrameworkViewController ()

@end

@implementation DynamicFrameworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *dynamicAction = [UIButton buttonWithType:UIButtonTypeCustom];
    dynamicAction.frame = CGRectMake(0, 0, 100, 40);
    dynamicAction.center = self.view.center;
    [dynamicAction setTitle:@"测试动态库" forState:UIControlStateNormal];
    
    [dynamicAction setBackgroundColor:[UIColor grayColor]];
    [dynamicAction addTarget:self action:@selector(testFramework) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dynamicAction];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteFile
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = nil;
    if ([paths count] != 0)
        documentDirectory = [paths objectAtIndex:0];
    
    NSString *libName = @"PacteraFramework.framework";
    NSString *destLibPath = [documentDirectory stringByAppendingPathComponent:libName];
    
    NSString *zipLibName = @"DynamicFramework.framework";
    NSString *destZipLibPath = [documentDirectory stringByAppendingPathComponent:zipLibName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:destLibPath]) {
        [manager removeItemAtPath:destLibPath error:nil];
    }
    
    if ([manager fileExistsAtPath:destZipLibPath]) {
        [manager removeItemAtPath:destZipLibPath error:nil];
    }
}


- (void)testFramework
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = nil;
    if ([paths count] != 0)
        documentDirectory = [paths objectAtIndex:0];
    
    //拼接我们放到document中的framework路径
    NSString *libName = @"PacteraFramework.framework";
    NSString *destLibPath = [documentDirectory stringByAppendingPathComponent:libName];
    
    //判断一下有没有这个文件的存在　如果没有直接跳出
    NSString *zipLibName = @"PacteraFramework.framework.zip";
    NSString *destZipLibPath = [documentDirectory stringByAppendingPathComponent:zipLibName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:destZipLibPath] && ![manager fileExistsAtPath:destLibPath]) {
        NSLog(@"There isn't have libPath");
        return;
    }
    
    if ([manager fileExistsAtPath:destZipLibPath]) {
        BOOL unZipWorked = [SSZipArchive unzipFileAtPath:destZipLibPath toDestination:documentDirectory];
        if (unZipWorked) {
            [manager removeItemAtPath:destZipLibPath error:nil];
        } else {
            return;
        }
    }
    
    
//    //复制到程序中
    NSError *error = nil;
//
////    加载方式一：使用dlopen加载动态库的形式　使用此种方法的时候注意头文件的引入
//        void* lib_handle = dlopen([destLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_LOCAL);
//        if (!lib_handle) {
//            NSLog(@"Unable to open library: %s\n", dlerror());
//            return;
//        }
////    加载方式一　关闭的方法
////     Close the library.
//        if (dlclose(lib_handle) != 0) {
//            NSLog(@"Unable to close library: %s\n",dlerror());
//        }
//    
    //加载方式二：使用NSBundle加载动态库
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:destLibPath];
    if (frameworkBundle && [frameworkBundle load]) {
        NSLog(@"bundle load framework success.");
    } else {
        NSLog(@"bundle load framework err:%@",error);
        return;
    }

    /*
     *通过NSClassFromString方式读取类
     *PacteraFramework　为动态库中入口类
     */
    Class pacteraClass = NSClassFromString(@"PacteraFramework");
    if (!pacteraClass) {
        NSLog(@"Unable to get TestDylib class");
        return;
    }
    
    /*
     *初始化方式采用下面的形式
     　alloc　init的形式是行不通的
     　同样，直接使用PacteraFramework类初始化也是不正确的
     *通过- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
     　方法调用入口方法（showView:withBundle:），并传递参数（withObject:self withObject:frameworkBundle）
     */
    NSObject *pacteraObject = [pacteraClass new];
    [pacteraObject performSelector:@selector(showView:withBundle:) withObject:self withObject:frameworkBundle];
    
}
@end
