//
//  PlanDataProvider.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanDataProvider.h"
#import "PlanCell.h"
#import "DetailCell.h"
#import "TimeCell.h"

@interface PlanDataProvider()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic) UITextField *textfield;
@property (strong, nonatomic)UITextView *textView;
@end

@implementation PlanDataProvider

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.plan = [[Plan alloc]init];
    return NUMBER_OF_SECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case TITLE_PLACE_SECTION:{
            
            return 2;
        }
        case START_END_SECTION:{
            
            return 2;
        }
        case DETAIL_SECTION:{
            
            return 1;
        }
    }return 2;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   switch (indexPath.section) {
    case TITLE_PLACE_SECTION:
        switch (indexPath.row) {
            case TITLE:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"タイトル(必須)";
                cellType1.textField.tag = 1;
                cellType1.textField.delegate = self;
                return cellType1;
            }
            case PLACE:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"場所";
                cellType1.textField.tag = 2;
                cellType1.textField.delegate = self;
                return cellType1;
            }
        }break;
    case START_END_SECTION:
        switch (indexPath.row) {
            case START_TIME:{
                TimeCell *cellType3 = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
                NSDateFormatter *formatter = [NSDateFormatter new];
                formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
                formatter.dateFormat = @"YYYY/MM/dd HH:mm~";
                NSString *stringDate = [formatter stringFromDate:self.chosenDate];
                
                cellType3.startTimeLb.text = stringDate;
                return cellType3;
            }
            case END_TIME:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"終了時間(必須)";
                cellType1.textField.tag = 3;
                cellType1.textField.delegate = self;            }
        }break;
     case DETAIL_SECTION:
        switch (indexPath.row) {
            case START_TIME:{
                DetailCell *cellType5 = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
                CGRect rect = [[UIScreen mainScreen] bounds];
                UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width,200)];
                textView.delegate = self;
                textView.editable = YES;
                [cellType5.contentView addSubview:textView];
                return cellType5;
            }
        }break;

    }UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    NSInteger textfieldTag = textField.tag;
    if (textfieldTag == 3){
        
        self.textfield = [[UITextField alloc]init];
        self.textfield = textField;
        if ([self.delegate respondsToSelector:@selector(startEditingTextfield)])
        {
             [self.delegate startEditingTextfield];
        }
        [self.textView resignFirstResponder];
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldEditingChanged :(id)sender{
    UITextField *textField = (UITextField *)sender;
    
    NSInteger textfieldTag = textField.tag;
    if(textfieldTag == TEXT_TITLE){
        self.plan.planTitle = textField.text;
    }else if(textfieldTag == TEXT_PLACE){
        self.plan.place = textField.text;
    }else if(textfieldTag == TEXT_END_TIME){
        self.plan.strEndTime = textField.text;
    }
    self.plan.startTime = self.chosenDate;
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChangeSelection:(UITextView *)textView{
    self.textView = textView;
    self.plan.detail = textView.text;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

#pragma mark - privateMethod

-(void)setEndTime:(NSDate*)endDate{

    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd HH:mm~ ";
    NSString *strDate = [df stringFromDate:endDate];

    self.textfield.text = strDate;
    self.plan.strEndTime = strDate;
}





@end
