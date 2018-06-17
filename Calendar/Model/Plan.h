//
//  Plan.h
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject

@property (nonatomic) NSInteger planId;
@property (nonatomic) NSString *planTitle;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSString *strStartTime;
@property (nonatomic) NSString *strEndTime;
@property (nonatomic) NSString *place;
@property (nonatomic) NSString *detail;


@end
