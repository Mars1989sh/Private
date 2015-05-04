//
//  switchCell.h
//  Private
//
//  Created by Mars on 14/12/26.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeSwitchDelegate<NSObject>
-(void)changeSwitch:(UISwitch*)Switch;
@end

@interface switchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *lockSwitch;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak,nonatomic) id<ChangeSwitchDelegate> delegate;
@end
