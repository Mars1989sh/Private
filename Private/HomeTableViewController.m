//
//  HomeTableViewController.m
//  Private
//
//  Created by Mars on 14/11/5.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "HomeTableViewController.h"
#import "PrivateDB.h"
#import "DetailViewController.h"
#import "Details.h"
#import "ListCategoryCell.h"
#import "guideViewController.h"
#import "TestViewController.h"
#import "AddCell.h"


#define FIRST @"first_start"

@interface HomeTableViewController ()
{
    NSMutableArray *_listDict;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)addAction:(id)sender;
- (IBAction)editAction:(id)sender;
@end
@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:54.0/255.0 green:210.0/255.0 blue:167.0/255.0 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.editButton.title = @"Edit";
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self updateList];
    
    BOOL isPatternSet = ([[NSUserDefaults standardUserDefaults] valueForKey:kCurrentPattern]) ? YES: NO;
    if (!isPatternSet) {
        TestViewController *lockVc = [[TestViewController alloc]init];
        lockVc.infoLabelStatus = InfoStatusFirstTimeSetting;
        [self presentViewController:lockVc animated:NO completion:^{

        }];
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateList
{
    [self.tableView setEditing:NO animated:YES];
    _listDict = [[PrivateDB sharedInstance] selectAll];
    
    /*
    if ([_listDict count] == 0) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Sample Entry",@"title",@"SampleUser",@"username",@"SF",@"password",@"",@"passwordhine",@"",@"email",@"",@"notes",@"8",@"category", nil]; //8 for others.
        
        [[PrivateDB sharedInstance] insertWith:dict];
    }
     */
    
    _listDict = [[PrivateDB sharedInstance] selectAll];


    
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
    return [_listDict count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath row] == [_listDict count]) {
        AddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell"];
        if (cell == nil) {
            NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"AddCell" owner:self options:nil];
            cell = [nibTableCells objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSDictionary *dict = [_listDict objectAtIndex:[indexPath row]];
        static NSString *CellIdentifier = @"CategoryCell";
        ListCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"ListCategoryCell" owner:self options:nil];
            cell = [nibTableCells objectAtIndex:0];
        }
        cell.title.text    = [dict objectForKey:@"title"];
        NSString *name = [dict objectForKey:@"username"];
        NSString *password = [dict objectForKey:@"password"];
        if (![name isEqualToString:@""] && ![password isEqualToString:@""]) {
            cell.username.text = [NSString stringWithFormat:@"%@ / %@",name,password];
        }else{
            cell.username.text = [NSString stringWithFormat:@"%@%@",name,password];
        }
        cell.image.image   = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@",[dict objectForKey:@"category"]]];
        return cell;
    }
}

//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if ([indexPath row] == [_listDict count]) {
        [self performSegueWithIdentifier:@"AddSegue" sender:nil];
    }else{
        [self performSegueWithIdentifier:@"DetailSegue" sender:indexPath];
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dict = [_listDict objectAtIndex:[indexPath row]];
        [[PrivateDB sharedInstance] deleteWithIndex:[[dict objectForKey:@"id"] integerValue]];
        [self.tableView setEditing:NO animated:YES];
        [_listDict removeObjectAtIndex:[indexPath row]];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == [_listDict count])
        return NO;
    else
        return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([indexPath row] == [_listDict count])
        return NO;
    else
        return YES;
}


// Override to support rearranging the table view.
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if ([destinationIndexPath row] == [_listDict count]) {
        [self.tableView reloadData]; 
        return;
    }
    
    [[PrivateDB sharedInstance] moveIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
    
    //    需要的移动行
    NSInteger fromRow = [sourceIndexPath row];
    //    获取移动某处的位置
    NSInteger toRow = [destinationIndexPath row];
    
    
    //    从数组中读取需要移动行的数据
    id object = [_listDict objectAtIndex:fromRow];
    //    在数组中移动需要移动的行的数据
    
    
    [_listDict removeObjectAtIndex:fromRow];
    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
    [_listDict insertObject:object atIndex:toRow];
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AddSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController *detailView = (DetailViewController *)(segue.destinationViewController);
            detailView.details = nil;
            detailView.categoryId = -1;
        }
    }
    else if ([segue.identifier isEqualToString:@"DetailSegue"])
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
    [self performSegueWithIdentifier:@"AddSegue" sender:nil];
}



- (IBAction)editAction:(id)sender
{
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        self.editButton.title = @"Edit";
//        UITableViewCell* firstCell = [[self.tableView visibleCells] objectAtIndex:[_listDict count]];
//        AddCell* addCell =  (AddCell*)firstCell;
//        addCell.hidden = NO;
    }else{
        [self.tableView setEditing:YES animated:YES];
        self.editButton.title = @"Done";
//        UITableViewCell* firstCell = [[self.tableView visibleCells] objectAtIndex:[_listDict count]];
//        AddCell* addCell =  (AddCell*)firstCell;
//        addCell  = nil;
    }
}
@end
