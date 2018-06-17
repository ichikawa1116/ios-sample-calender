//
//  ScheduleManager.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ScheduleManager.h"
#import "FMDB.h"
#import "Plan.h"

@interface ScheduleManager ()

@property(nonatomic,copy) NSString* db_path;
@end

@implementation ScheduleManager

-(id)init{
    
    self = [super init];
    if(self){
        FMDatabase* db = [self getConnection];
        [db open];
        NSString *sql = @"CREATE TABLE IF NOT EXISTS  t_plan(plan_id INTEGER PRIMARY KEY AUTOINCREMENT, plan_title TEXT, place TEXT, start_date INTEGER, end_date INTEGER, detail TEXT); ";
        [db executeUpdate:sql];
        [db close];
    }
    return self;
}

+(NSString*)getDbFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSLog(@"%@",paths);
    NSString *dir = [paths
                     objectAtIndex:0];
    return [dir stringByAppendingPathComponent:@"plan.db"];
}

-(void)addNewPlan:(Plan*)plan{
    
    NSString *title      = plan.planTitle;
    NSDate *startDate    = plan.startTime;
    NSDate *endDate      = plan.endTime;
    NSString *place      = plan.place;
    NSString *detail     = plan.detail;
    
    FMDatabase* db = [self getConnection];
    [db open];
    [db beginTransaction];
    
    NSString *sql = @"INSERT INTO t_plan (plan_title, start_date, end_date, place, detail) VALUES (?,?,?,?,?)";
    
    [db executeUpdate:sql,title,startDate,endDate,place,detail];
    
    [db commit];
    [db close];
}

-(NSMutableArray<Plan*>*)showPlanList{
    
    FMDatabase *db = [self getConnection];
    NSString *sqlite = @"SELECT* FROM t_plan";
    [db open];
    FMResultSet* results = [db executeQuery:sqlite];
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while ([results next]){
        Plan* plan = [[Plan alloc] init];
        
        plan.planId       = [results intForColumn:@"plan_id"];
        plan.planTitle    = [results stringForColumn:@"plan_title"];
        plan.startTime    = [results dateForColumn:@"start_date"];
        plan.endTime      = [results dateForColumn:@"end_date"];
        plan.place        = [results stringForColumn:@"place"];
        plan.detail       = [results stringForColumn:@"detail"];
        
        [list addObject:plan];
    }
    [db close];
    return list;    
}

-(Plan*)showThePlan:(NSDate*)date{

    Plan* plan = [[Plan alloc] init];
    FMDatabase *db = [self getConnection];
    NSString *sqlite = @"SELECT* FROM t_plan WHERE start_date = ?";
    [db open];
    FMResultSet* results = [db executeQuery:sqlite,date];
    while ([results next]){
        
        plan.planId       = [results intForColumn:@"plan_id"];
        plan.planTitle    = [results stringForColumn:@"plan_title"];
        plan.startTime    = [results dateForColumn:@"start_date"];
        plan.endTime      = [results dateForColumn:@"end_date"];
        plan.place        = [results stringForColumn:@"place"];
        plan.detail       = [results stringForColumn:@"detail"];
    }
    
    [db close];
    return plan;
}


-(FMDatabase*)getConnection{
    if(self.db_path == nil){
        self.db_path = [ScheduleManager getDbFilePath];
    }
    
    return [FMDatabase databaseWithPath:self.db_path];
};


@end
