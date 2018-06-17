//
//  PlanListDataProvider.h
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Hour.h"

@interface PlanListDataProvider : NSObject<UITableViewDataSource>

@property (nonatomic) NSMutableArray<Hour*> *timeArray;
@end
