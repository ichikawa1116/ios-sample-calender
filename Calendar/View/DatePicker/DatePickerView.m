//
//  DatePickerView.m
//  Calendar
//
//  Created by Manami Ichikawa on 8/13/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

+ (instancetype)dateView
{
    UINib *nib = [UINib nibWithNibName:@"DatePickerView" bundle:nil];
    DatePickerView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
    
}
@end
