//
//  ModalViewController.m
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "ModalViewController.h"
#import "UIColor+CustomColors.h"
#import "CategoryCell.h"

@interface ModalViewController()<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *_mainView;
    NSArray* _categoryData;
}
//- (void)addDismissButton;
- (void)dismiss:(id)sender;
@end

@implementation ModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatView];
    [self creatTableView];
    _row = -1;
    NSLog(@"width:%f height:%f",self.view.frame.size.width,self.view.frame.size.height);
}

/*
#pragma mark - Private Instance methods

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:dismissButton];

    [_mainView addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_mainView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [_mainView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}
 */

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
    _mainView.backgroundColor = [UIColor customYellowColor];
    _mainView.frame = CGRectMake(0,0,300,400);
    _mainView.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
    _mainView.layer.masksToBounds = YES;
    _mainView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _mainView.layer.cornerRadius = 12;
    [self.view addSubview:_mainView];
}



-(void)creatTableView
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    _categoryData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    UITableView* tableView = [[UITableView alloc] init];
    [tableView setFrame:CGRectMake(0, 0, _mainView.frame.size.width, _mainView.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1];
    [_mainView addSubview:tableView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_categoryData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    _row = [indexPath row];
    [self dismiss:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CategoryCell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.count.hidden = YES;
    cell.title.text = [_categoryData objectAtIndex:[indexPath row]];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)[indexPath row]]];
    return cell;
}
@end
