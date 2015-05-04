//
//  ListCategoryTableViewController.m
//  Private
//
//  Created by Mars on 14/11/27.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "ListCategoryTableViewController.h"
#import "PrivateDB.h"
#import "DetailViewController.h"
#import "Details.h"
#import "ListCategoryCell.h"

@interface ListCategoryTableViewController ()
{
    NSMutableArray *_listarr;
    NSArray *_listDict;
}

- (IBAction)addAction:(id)sender;
@end
@implementation ListCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _categoryText;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateList
{
    _listDict = [[PrivateDB sharedInstance] selectCategoryWith:_categoryId];
    NSLog(@"listDict:%@",_listDict);
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_listDict count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_listDict objectAtIndex:[indexPath row]];

    static NSString *CellIdentifier = @"CategoryCell";
    ListCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"ListCategoryCell" owner:self options:nil];
        cell = [nibTableCells objectAtIndex:0];
    }
    NSString *name = [dict objectForKey:@"username"];
    NSString *password = [dict objectForKey:@"password"];
    cell.title.text = [dict objectForKey:@"title"];
    if (![name isEqualToString:@""] && ![password isEqualToString:@""]) {
        cell.username.text = [NSString stringWithFormat:@"%@ / %@",name,password];
    }else{
        cell.username.text = [NSString stringWithFormat:@"%@%@",name,password];
    }
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@",[dict objectForKey:@"category"]]];
    return cell;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [self performSegueWithIdentifier:@"ListDetailSegue" sender:indexPath];
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dict = [_listDict objectAtIndex:[indexPath row]];
        [[PrivateDB sharedInstance] deleteWithIndex:[[dict objectForKey:@"id"] integerValue]];
        //[_listarr removeObjectAtIndex:[indexPath row]];
        [self updateList];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}




// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ListAddSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController *detailView = (DetailViewController *)(segue.destinationViewController);
            detailView.details  = nil;
            detailView.categoryId = _categoryId;
        }
    }
    else if ([segue.identifier isEqualToString:@"ListDetailSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController *detailView = (DetailViewController *)(segue.destinationViewController);
            NSIndexPath *indexPath = sender;
            NSDictionary *dict = [_listDict objectAtIndex:[indexPath row]];
            
            Details *details  = [[Details alloc] init];
            details.rid          = [[dict objectForKey:@"id"] integerValue];
            details.category     = [[dict objectForKey:@"category"] integerValue];
            details.title        = [dict objectForKey:@"title"];
            details.username     = [dict objectForKey:@"username"];
            details.password     = [dict objectForKey:@"password"];
            details.passwordhine = [dict objectForKey:@"passwordhine"];
            details.email        = [dict objectForKey:@"email"];
            details.notes        = [dict objectForKey:@"notes"];
            detailView.details = details;
        }
    }
}


- (IBAction)addAction:(id)sender
{
    [self performSegueWithIdentifier:@"ListAddSegue" sender:nil];
}


@end