//
//  PickerViewController.m
//  Private
//
//  Created by Mars on 15/1/5.
//  Copyright (c) 2015年 MarsZhang. All rights reserved.
//

#import "PickerViewController.h"
#import "UIColor+CustomColors.h"




@interface PickerViewController ()<UIGestureRecognizerDelegate,UIPickerViewDelegate>
{
    UIView *_mainView;
    NSArray* _timeData;
}
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    [self creatPickerView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gestureRecognized:(UIGestureRecognizer*) gestureRecoginzer
{
    [self dismiss:nil];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)creatView
{
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor clearColor];
    
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = self.view.frame;
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    recog.delegate = self;
    recog.delaysTouchesEnded = NO;
    recog.cancelsTouchesInView = NO;
    [backgroundView addGestureRecognizer:recog];
    [self.view addSubview:backgroundView];
    
    _mainView = [[UIView alloc] init];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.frame = CGRectMake(0,0,250,250);
    _mainView.center = CGPointMake(self.view.center.x, self.view.center.y);
    _mainView.layer.masksToBounds = YES;
    _mainView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _mainView.layer.cornerRadius = 12;
    [self.view addSubview:_mainView];
}



-(void)creatPickerView
{
    _timeData = [[NSArray alloc] initWithObjects:@"auto",@"1min",@"2min",@"3min",@"4min",@"5min", nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 250, 230)];
    //    指定Delegate
    pickerView.delegate=self;
    //    显示选中框
    pickerView.showsSelectionIndicator=YES;
    
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    if ([stdDefault valueForKey:AUTOTIME]) {
        NSInteger selrow = [[stdDefault valueForKey:AUTOTIME] intValue];
        [pickerView selectRow:selrow inComponent:0 animated:YES];
    }else{
        [pickerView selectRow:0 inComponent:0 animated:YES];
    }
    
    UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(80, 210, 100, 40)];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor colorWithRed:106.0/255.0 green:225.0/255.0 blue:194.0/255.0 alpha:1] forState:UIControlStateNormal];
    [done addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchDown];
    [_mainView addSubview:pickerView];
    [_mainView addSubview:done];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}


//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_timeData count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_timeData objectAtIndex:row];
}


-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    NSInteger selrow = row;
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    [stdDefault setValue:@(selrow) forKey:AUTOTIME];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
