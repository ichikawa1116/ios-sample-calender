//
//  ViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 4/10/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

//ViewController
#import "CalendarViewController.h"
#import "PlanListViewController.h"
//View
#import "DayCell.h"
#import "CalendarViewDataSource.h"
//Model
#import "CalendarLogic.h"
#import "ScheduleManager.h"
#import "Plan.h"
//Category
#import "NSDate+Calendar.h"





@interface CalendarViewController (){

    NSInteger numberOfItems;
    NSInteger numberOfWeeks;

}

@property (strong, nonatomic) CalendarLogic *calendarLogic;
@property (strong, nonatomic) NSArray *weekOfDays;
@property (strong, nonatomic) NSDate *showedDate;
@property (strong, nonatomic) NSDate *aDate;
@property (strong, nonatomic) CalendarViewDataSource *calendarViewDataSource;

@end

@implementation CalendarViewController


static NSUInteger const DaysPerWeek = 7;
static CGFloat const CellMargin = 2.0f;

# pragma mark - hierarchy
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINib *nib = [UINib nibWithNibName:@"DayCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.aDate  = [NSDate date];
    
    self.calendarViewDataSource = [[CalendarViewDataSource alloc] initWithCalendars:[CalendarLogic calendarWithDate:self.aDate]];
    
    self.collectionView.dataSource = self.calendarViewDataSource;
    self.collectionView.delegate = self;
    
    [self.calendarViewDataSource.calendars objectAtIndex:0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM月YYYY年";
    self.navigationItem.title = [self.aDate dateStringWithFormat:formatter.dateFormat];

    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate methods


//　セル同士の間隔は定数で2.0f　7行6列で表示させる
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfMargin = 8;
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysPerWeek);
    if(indexPath.section == 0){
        CGFloat height = width ;
        return CGSizeMake(width, height);
    }
    CGFloat height = width*1.5 ;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.calendarLogic = self.calendarViewDataSource.calendars[indexPath.row];
    
    // 該当月の日付なら画面遷移
    if (!self.calendarLogic.isDifferentMonth){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PlanList" bundle:[NSBundle mainBundle]];
                
        PlanListViewController *secondVC = [storyboard instantiateInitialViewController];
       
        secondVC.selectedDate = self.calendarLogic;
        [self.navigationController pushViewController:secondVC animated:true];
    }

}

#pragma mark - private method
- (IBAction)goToNextMonth:(id)sender {
    
    self.aDate = [self.aDate monthLaterDate];
    self.calendarViewDataSource.calendars = [CalendarLogic calendarWithDate:self.aDate];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM月YYYY年";
    self.navigationItem.title = [self.aDate dateStringWithFormat:formatter.dateFormat];
    
    [self.collectionView reloadData];
    
}

- (IBAction)goToLastMonth:(id)sender {
   
    self.aDate = [self .aDate monthAgoDate];
    self.calendarViewDataSource.calendars = [CalendarLogic calendarWithDate:self.aDate];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM月YYYY年";
    self.navigationItem.title = [self.aDate dateStringWithFormat:formatter.dateFormat];
    [self.collectionView reloadData];
}
@end
