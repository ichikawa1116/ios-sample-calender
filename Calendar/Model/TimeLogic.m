//
//  TimeLogic.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "TimeLogic.h"
#import "ScheduleManager.h"
#import "Plan.h"

@implementation TimeLogic

-(NSMutableArray<Hour *>*)setTimeLine:(CalendarLogic*)selectedDate{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:selectedDate.aDate];
    
    components.hour = 00;
    components.minute = 00;
    
    NSDate *timeLineComp = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSDate *timeComp;
    NSMutableArray<Hour*> *timeList = [[NSMutableArray alloc]init];
    for(int i=0;i<47;i++){
       
        Hour *hour = [[Hour alloc]init];
        timeComp = [timeLineComp initWithTimeInterval:30*60 sinceDate:timeLineComp];
        timeLineComp = timeComp;
        hour.anHour = timeComp;
        hour.isAvailabel = [self checkTimeIfThereAreAnyPlans:hour];
        [timeList addObject:hour];
    }
        
    return timeList;
}

-(BOOL)checkTimeIfThereAreAnyPlans :(Hour*)hour{

    ScheduleManager *manager = [[ScheduleManager alloc]init];
    NSMutableArray<Plan*> *list = [[NSMutableArray alloc]init];

    Plan *plan = [[Plan alloc]init];
    list = [manager showPlanList];
    for(plan in list){
        
        NSDate *startDate = plan.startTime;
        NSDate *endDate = plan.endTime;
        
        //startDate,endDateはDBの値
        
        NSComparisonResult startRes = [hour.anHour compare:startDate];
        NSComparisonResult endRes = [hour.anHour compare:endDate];
        
        if((startRes == NSOrderedDescending || startRes == NSOrderedSame) && (endRes == NSOrderedAscending || endRes == NSOrderedSame)){
            if ([hour.anHour compare:endDate] == NSOrderedDescending) {
                return NO;
            }
            return YES;
        }
        
    }
    return NO;
}


@end
