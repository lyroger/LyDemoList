//
//  CTDisplayView.m
//  DemoList
//
//  Created by luoyan on 15/12/30.
//  Copyright © 2015年 luoyan. All rights reserved.
//

#import "CTDisplayView.h"
#import "Coretext/CoreText.h"

@implementation CTDisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor whiteColor];
    [super drawRect:rect];
    CGContextRef content = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(content, CGAffineTransformIdentity);
    CGContextTranslateCTM(content, 0, self.bounds.size.height);
    CGContextScaleCTM(content, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World!" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, content);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"0");
    
    dispatch_sync(queue, ^(){
        NSLog(@"sync");
    });
    
    dispatch_async(queue, ^(){
        NSLog(@"1");
        dispatch_queue_t queue2 = dispatch_queue_create("myQueue2", DISPATCH_QUEUE_CONCURRENT);
        dispatch_sync(queue2, ^(){
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    
    dispatch_async(queue, ^(){
        NSLog(@"4");
    });
    
    dispatch_async(queue, ^(){
        NSLog(@"5");
    });
    
    NSLog(@"6");
    
//    dispatch_group_t group = dispatch_group_create();
//    
//    dispatch_queue_t gqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
//        NSLog(@"all finished");
//    });
//    
//    
//    dispatch_group_async(group, gqueue, ^(){
//        for (int i = 0; i<100; i++) {
//            
//        }
//        NSLog(@"for 100 finished");
//    });
//    
//    dispatch_group_async(group, gqueue, ^(){
//        for (int i = 0; i<1000; i++) {
//            
//        }
//        NSLog(@"for 1000 finished");
//    });
//
//    dispatch_group_async(group, gqueue, ^(){
//        for (int i = 0; i<100000; i++) {
//            
//        }
//        NSLog(@"for 100000 finished");
//    });
    
//    NSInvocationOperation *op
    
    

}

- (void)doSomething
{
    NSLog(@"doSomething");
}


@end
