//
//  PlanListDataProvider.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanListDataProvider.h"
#import "ScheduleCell.h"

@implementation PlanListDataProvider

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Hour *hour = [[Hour alloc]init];
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    formatter.dateFormat = @"HH:mm~";
    hour = [self.timeArray objectAtIndex:indexPath.row];
    NSLog(@"indexPath.row =%ld ",indexPath.row);
    if(hour.isAvailabel){
        cell.backgroundColor = [UIColor cyanColor];
    }else{
        
    /* メモ: セルが再利用され、スクロール時に色がついたセルが不本意な箇所に再び登場するため、この処理追加　*/
        cell.backgroundColor = [UIColor whiteColor];
    }

    NSString *stringDate = [formatter stringFromDate:hour.anHour];
    cell.timeLb.text = stringDate;
        return cell;
}



@end
