//
//  CategoryTableViewController.m
//  Private
//
//  Created by Mars on 14/12/8.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "ListCategoryTableViewController.h"
#import "CategoryCell.h"
#import "PrivateDB.h"

@interface CategoryTableViewController ()
{
    NSArray *_valueCategory;
    NSMutableArray *_keyCategory;
    NSArray *_categoryData;
}
@end

@implementation CategoryTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self orderList];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

NSInteger floatSort(id num1, id num2, void *context)
{
    float v1 = [num1 floatValue];
    float v2 = [num2 floatValue];
    if (v1 < v2)
        return NSOrderedDescending;
    else if (v1 > v2)
        return NSOrderedAscending;
    else
        return NSOrderedSame;
}

-(void)orderList
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    _categoryData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (int i=0;i<[_categoryData count];i++) {
        NSArray *listDict = [[PrivateDB sharedInstance] selectCategoryWith:i];
        NSInteger count   = [listDict count];
        [dict setObject:@(count) forKey:@(i)];
    }
    NSArray *allValues = [dict allValues];
    _valueCategory = [allValues sortedArrayUsingFunction:floatSort context:NULL];
    _keyCategory = [[NSMutableArray alloc] init];
    for (id key in _valueCategory)
    {
        for (int i=0;i<9;i++) {
            if ((int)key == (int)[dict objectForKey:@(i)]) {
                [_keyCategory addObject:@(i)];
                [dict removeObjectForKey:@(i)];
                break;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_categoryData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
    }
    cell.title.text = [_categoryData objectAtIndex:[[_keyCategory objectAtIndex:[indexPath row]] integerValue]];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)[[_keyCategory objectAtIndex:[indexPath row]] integerValue]]];
    cell.count.text = [NSString stringWithFormat:@"%ld",
                       (long)[[_valueCategory objectAtIndex:[indexPath row]] integerValue]];
    return cell;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [self performSegueWithIdentifier:@"ListCategorySegue" sender:indexPath];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

   if ([segue.identifier isEqualToString:@"ListCategorySegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[ListCategoryTableViewController class]]) {
            ListCategoryTableViewController *view = (ListCategoryTableViewController *)(segue.destinationViewController);
            NSIndexPath *indexPath = sender;
            view.categoryText = [_categoryData objectAtIndex:[[_keyCategory objectAtIndex:[indexPath row]] integerValue]];
            view.categoryId = [[_keyCategory objectAtIndex:[indexPath row]] integerValue];
        }
    }
}

@end
