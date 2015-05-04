//
//  TestViewController.h
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLockScreen.h"

#define kCurrentPattern												@"KeyForCurrentPatternToUnlock"
#define kCurrentPatternTemp										@"KeyForCurrentPatternToUnlockTemp"

typedef enum {
	InfoStatusFirstTimeSetting = 0,
	InfoStatusConfirmSetting,
	InfoStatusFailedConfirm,
	InfoStatusNormal,
	InfoStatusFailedMatch,
	InfoStatusSuccessMatch,
    InfoStatusChangeErro,
    InfoStatusChange
}	InfoStatus;


@interface TestViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet SPLockScreen *lockScreenView;
@property (nonatomic) InfoStatus infoLabelStatus;

@end
