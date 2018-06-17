//
//  ScheduleManager.h
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plan.h"
@interface ScheduleManager : NSObject

-(id)init;
-(void)addNewPlan:(Plan*)plan;
-(NSMutableArray<Plan*>*)showPlanList;
-(Plan*)showThePlan:(NSDate*)date;

@end
