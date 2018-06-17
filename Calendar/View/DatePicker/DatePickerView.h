//
//  DatePickerView.h
//  Calendar
//
//  Created by Manami Ichikawa on 8/13/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

+ (instancetype)dateView;

@end
