//
//  SetTableViewController.m
//  Private
//
//  Created by Mars on 14/11/26.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "SetTableViewController.h"
#import "TestViewController.h"
#import "switchCell.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "PickerViewController.h"

@interface SetTableViewController ()<UIViewControllerTransitioningDelegate,ChangeSwitchDelegate>
{
    NSArray *_list;
}
@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _list = [[NSArray alloc] initWithObjects:@"Change password",@"Auto-lock",@"Lock when exit",@"About", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 2) {
        static NSString *CellIdentifier = @"switchCell";
        switchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"switchCell" owner:self options:nil];
            cell = [nibTableCells objectAtIndex:0];
        }
        cell.title.text = [_list objectAtIndex:[indexPath row]];
        cell.delegate = self;
        
        
        NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
        NSInteger autoLock = [[stdDefault valueForKey:AUTOTIME] integerValue];
        if (autoLock) {
            [cell.lockSwitch setOn:NO];
        }else{
            [cell.lockSwitch setOn:YES];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = [_list objectAtIndex:[indexPath row]];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    switch ([indexPath row]) {
        case 0:{
                TestViewController *lockVc = [[TestViewController alloc] init];
                lockVc.infoLabelStatus = InfoStatusChange;
                [self presentViewController:lockVc animated:NO completion:^{}];
            }
            break;
        case 1:
            [self showTimePicker];
            break;
        case 3:
            [self performSegueWithIdentifier:@"AboutSegue" sender:indexPath];
            break;
        default:
            break;
    }
}

- (void)showTimePicker
{
    //[self hiddenKeyboard];
    PickerViewController *pickerViewController = [PickerViewController new];
    pickerViewController.transitioningDelegate = self;
    pickerViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:pickerViewController
                                            animated:YES
                                          completion:NULL];
}



#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [self.tableView reloadData];
    return [DismissingAnimator new];
}

-(void)changeSwitch:(UISwitch*)Switch
{
    NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
    if ([Switch isOn]) {
        [stdDefault setValue:@(0) forKey:AUTOTIME];
    }else{
        //[stdDefault setValue:@(YES) forKey:AUTOTIME];
        [self showTimePicker];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
