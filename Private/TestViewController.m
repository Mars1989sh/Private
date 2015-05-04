//
//  TestViewController.m
//  SuQian
//
//  Created by Suraj on 24/9/12.
//  Copyright (c) 2012 Suraj. All rights reserved.
//

#import "TestViewController.h"
#import "NormalCircle.h"
#define FIRST @"first_start"

@interface TestViewController ()<LockScreenDelegate>

@property (nonatomic) NSInteger wrongGuessCount;
@end

@implementation TestViewController
@synthesize infoLabelStatus,wrongGuessCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:251.0/255.0 blue:255.0/255.0 alpha:1];
}


//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self outsite];
//}

- (void)viewDidAppear:(BOOL)animated
{	
	[super viewDidAppear:animated];
	
	self.lockScreenView = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    self.lockScreenView.center = CGPointMake(self.view.center.x, self.view.center.y+50);
	self.lockScreenView.delegate = self;
	self.lockScreenView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.lockScreenView];
	
	self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
	self.infoLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.font = [UIFont systemFontOfSize:19];
	self.infoLabel.textColor = [UIColor blackColor];
	self.infoLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.infoLabel];
	
	[self updateOutlook];
	 
	
	// Test with Circular Progress
}


- (void)updateOutlook
{
	switch (self.infoLabelStatus) {
        case InfoStatusChange:
            self.infoLabel.text = @"Input pattern passcode";
            break;
        case InfoStatusChangeErro:
            self.infoLabel.text = [NSString stringWithFormat:@"Try(%ld) again !",(long)self.wrongGuessCount];
            break;
		case InfoStatusFirstTimeSetting:
			self.infoLabel.text = @"Set a pattern";
			break;
		case InfoStatusConfirmSetting:
			self.infoLabel.text = @"Confirm the pattern";
			break;
		case InfoStatusFailedConfirm:
			self.infoLabel.text = @"Not matched. Retry";
			break;
		case InfoStatusNormal:
			self.infoLabel.text = @"Input pattern passcode";
			break;
		case InfoStatusFailedMatch:
			self.infoLabel.text = [NSString stringWithFormat:@"Wrong Guess # %ld, try again",(long)self.wrongGuessCount];
			break;
		case InfoStatusSuccessMatch:
			self.infoLabel.text = @"Welcome";
			break;
			
		default:
			break;
	}
	
}


#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@"self status: %d",self.infoLabelStatus);
	switch (self.infoLabelStatus) {
        case InfoStatusChange:
            if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]])
            {
                self.infoLabelStatus = InfoStatusFirstTimeSetting;
                [self updateOutlook];
                break;
            }
            else {
                self.wrongGuessCount ++;
                self.infoLabelStatus = InfoStatusChangeErro;
                [self updateOutlook];
            }
            break;
        case InfoStatusChangeErro:
            if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]])
            {
                self.infoLabelStatus = InfoStatusFirstTimeSetting;
                [self updateOutlook];
                break;
            }
            else {
                self.wrongGuessCount ++;
                self.infoLabelStatus = InfoStatusChangeErro;
                [self updateOutlook];
            }
            break;
		case InfoStatusFirstTimeSetting:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusFailedConfirm:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusConfirmSetting:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPatternTemp]]) {
                NSUserDefaults *Default = [NSUserDefaults standardUserDefaults];
                [Default setValue:@(YES) forKey:FIRST];
				[stdDefault setValue:patternNumber forKey:kCurrentPattern];
                [self outsite];
                //[self dismissViewControllerAnimated:YES completion:nil];
			}
			else {
				self.infoLabelStatus = InfoStatusFailedConfirm;
				[self updateOutlook];
			}
			break;
		case  InfoStatusNormal:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]])
                [self outsite];
                //[self dismissViewControllerAnimated:YES completion:nil];
			else {
				self.infoLabelStatus = InfoStatusFailedMatch;
				self.wrongGuessCount ++;
				[self updateOutlook];
			}
			break;
		case InfoStatusFailedMatch:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPattern]])
                //[self dismissViewControllerAnimated:YES completion:nil];
                [self outsite];
			else {
				self.wrongGuessCount ++;
				self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
			}
			break;
		case InfoStatusSuccessMatch:
            
			//[self dismissViewControllerAnimated:YES completion:nil];
            [self outsite];
            break;
			
		default:
			break;
	}
}

-(void)outsite
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view removeFromSuperview];
}

- (void)viewDidUnload {
	[self setInfoLabel:nil];
	[self setLockScreenView:nil];
	[super viewDidUnload];
}
@end
