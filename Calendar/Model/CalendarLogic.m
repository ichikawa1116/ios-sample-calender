//
//  CalendarLogic.m
//  Calendar
//
//  Created by Manami Ichikawa on 4/11/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "CalendarLogic.h"
#import "ScheduleManager.h"

@implementation CalendarLogic

static NSUInteger const DaysPerWeek = 7;
-(NSDate*)getThisMonth{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:components];
    
    return today;
    
}

+(NSArray<CalendarLogic *> *)calendarWithDate:(NSDate *)date{

    //受け取った日付の入った月を要素ごとに分ける。
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    components.day = 1;
    
    NSDate *firstDateOfMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    
    NSInteger numberOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:firstDateOfMonth].length;
    
    
    NSInteger numberOfDaysInMonth = numberOfWeeks * DaysPerWeek;
    
    NSMutableArray *calendars = [@[] mutableCopy];
    
    
    //restOfTheLastMonthは一日が表示されている４２個のセルのうち何番目か取得
    NSInteger restOfTheLastMonth = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                                           inUnit:NSCalendarUnitWeekOfMonth
                                                                          forDate:firstDateOfMonth];
    ScheduleManager *manager = [[ScheduleManager alloc]init];
    NSMutableArray<Plan*> *plans = [[NSMutableArray alloc]init];
    plans = [manager showPlanList];
    NSMutableArray<NSString*>*recordedDate = [[NSMutableArray alloc]init];
    for(Plan *plan in plans){
        
        NSDateFormatter *df =[[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy/MM/dd ";
        NSString *stringDate = [df stringFromDate:plan.startTime];
        
        [recordedDate addObject:stringDate];
    }
    
    for (NSInteger i = 0; i < numberOfDaysInMonth; i++) {
                
        NSDateComponents *nextComponents = [[NSDateComponents alloc]init];
        nextComponents.day = i - (restOfTheLastMonth - 1);
        
        //表示される日
        NSDate *aDate = [[NSCalendar currentCalendar] dateByAddingComponents:nextComponents
                                                                         toDate:firstDateOfMonth
                                                                        options:0];
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd ";
        NSString *strDate = [formatter stringFromDate:aDate];

        BOOL AreAnyPlans = [self compareDateToDesplayedDate:recordedDate Desplay:strDate];
        NSInteger month = [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date] month];
        
        
        
        //表示される一覧の月だけを取得->ここで表示される月のうち先月、今月、来月に分かれる
        NSInteger monthOfTheDate = [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate] month];
        
        [calendars addObject:[[CalendarLogic alloc] initWithDate:aDate isDifferentMonth:month != monthOfTheDate AnyPlans:AreAnyPlans]];
    }
    
    return calendars;
}

- (instancetype)initWithDate:(NSDate *)date isDifferentMonth:(BOOL)isDifferentMonth AnyPlans:(BOOL)AreAnyPlans{
    if (self = [super init]) {
        self.aDate = date;
        
        //今月の日付 = 0 , それ以外の日付 = 1
        self.isDifferentMonth = isDifferentMonth;
        self.AreAnyPlans = AreAnyPlans;
    }
    return self;
}

+ (BOOL)compareDateToDesplayedDate:(NSMutableArray<NSString*>*)recordedDate Desplay:(NSString*)strDate{
    
    BOOL isContains = [recordedDate containsObject:strDate];

    return isContains;
}
    
    




@end
