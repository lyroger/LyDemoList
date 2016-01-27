//
//  CalendarViewController.m
//  DemoList
//
//  Created by luoyan on 16/1/26.
//  Copyright © 2016年 luoyan. All rights reserved.
//

#import "CalendarViewController.h"
#import <EventKit/EventKit.h>

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeCalendarEvent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeCalendarEvent
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //等待用户是否同意授权日历
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error)
            {
                NSLog(@"%@",error);
            }
            else if (!granted)
            {
                //被⽤用户拒绝,不允许访问⽇日历
            }
            else
            {
                NSDate* ssdate = [NSDate dateWithTimeIntervalSinceNow:-3600*24*365];//事件段，开始时间
                NSDate* ssend = [NSDate dateWithTimeIntervalSinceNow:3600*24*365];//结束时间，取中间
                NSPredicate* predicate = [eventStore predicateForEventsWithStartDate:ssdate
                                                                             endDate:ssend
                                                                           calendars:nil];
                NSArray* events = [eventStore eventsMatchingPredicate:predicate];//数组里面就是时间段中的EKEvent事件数组
                [events enumerateObjectsUsingBlock:^(EKEvent *event, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (event.calendar.allowsContentModifications) {
//                        [eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:nil];
                        [eventStore removeEvent:event span:EKSpanThisEvent error:nil];
                    }
                    
                }];
                
            }
        });
    }];
    
}

@end
