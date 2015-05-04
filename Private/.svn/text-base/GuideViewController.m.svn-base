//
//  guideViewController.m
//  Private
//
//  Created by Mars on 15/1/12.
//  Copyright (c) 2015年 MarsZhang. All rights reserved.
//

#import "guideViewController.h"
#import "DrawGradient.h"
#import "HomeTableViewController.h"
#import "TestViewController.h"
#define TITLE_CONTROL_HEIGHT 200

#define FIRST @"first_start"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) UIButton *doneButton;
@end

@implementation GuideViewController


-(void)creatScroll
{
    BOOL first = ([[NSUserDefaults standardUserDefaults] valueForKey:FIRST]) ? YES: NO;
    if (first) {
        [self butClick];
    }else{
        
        if (_doneButton==nil) {
            _pageControl = [[UIPageControl alloc] init];
            _pageControl.frame = CGRectMake(0, 0, 100, 50);
            _pageControl.numberOfPages = 4;
            _pageControl.currentPage = 0;
            _pageControl.center = CGPointMake(self.view.center.x, self.view.frame.size.height-70);
            
            _scrollView = [[UIScrollView alloc] init];
            _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            _scrollView.pagingEnabled = YES;
            _scrollView.showsVerticalScrollIndicator = NO;
            _scrollView.showsHorizontalScrollIndicator = NO;
            _scrollView.bounces = NO;
            _scrollView.delegate = self;
            
            _doneButton = [[UIButton alloc] init];
            _doneButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:119/255.0 blue:67/255.0 alpha:1];
            _doneButton.frame = CGRectMake(0, 0, 300, 50);
            _doneButton.hidden = YES;
            _doneButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height-70);
            _doneButton.tintColor =  [UIColor  whiteColor];
            _doneButton.layer.masksToBounds = YES;
            _doneButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
            _doneButton.layer.cornerRadius = 6;
            [_doneButton addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
            [_doneButton setTitle:@"Start" forState:UIControlStateNormal];
            
            
            _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4,self.view.frame.size.height);
            for (int i= 1; i<=4; i++) {
                UIView *guideview = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*(i-1), 0, self.view.frame.size.width, self.view.frame.size.height)];
                guideview.backgroundColor = [DrawGradient DrawGradientWithIndex:i];
                //guideview.backgroundColor = [UIColor yellowColor];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i]]];
                imageView.frame = CGRectMake(0, 0, 298, 322);
                imageView.center = self.view.center;
                [guideview addSubview:imageView];
                [_scrollView addSubview:guideview];
            }
            

            [self.view addSubview:_scrollView];
            [self.view addSubview:_pageControl];
            [self.view addSubview:_doneButton];
        }
    }
}


-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self creatScroll];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)butClick
{
    [self performSegueWithIdentifier:@"GuideSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = fabs(_scrollView.contentOffset.x) / scrollView.frame.size.width;
    NSLog(@"contentOffsetx :%f",_scrollView.contentOffset.x);
    _pageControl.currentPage = page;
    [self changeHiddenStatusWithPage:page];
}


- (void)changeHiddenStatusWithPage:(NSInteger)page
{
    if (page == 3) {
        _pageControl.hidden = YES;
        _doneButton.hidden = NO;
//        if (_doneButton.alpha == 0) {
//                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    //[_doneButton setCenter:self.doneFixCenter];
//                    _doneButton.alpha = 1;
//                } completion:NULL];
//        }
    }else{
        _pageControl.hidden = NO;
        _doneButton.hidden = YES;
    }
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
