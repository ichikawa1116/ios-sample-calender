//
//  TimeLogic.h
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"CalendarLogic.h"
#import "Hour.h"

@interface TimeLogic : NSObject
@property NSDate *theDate;

-(NSMutableArray<Hour *>*)setTimeLine:(CalendarLogic*)selectedDate;
@end
