//
//  DetailViewController.m
//  Private
//
//  Created by Mars on 14/11/5.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "DetailViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "ModalViewController.h"
#import "PrivateDB.h"
#import <pop/POP.h>

#define KEYBOARD 160+64

@interface DetailViewController ()<UIViewControllerTransitioningDelegate,UITextFieldDelegate>
{
    NSArray* _categoryData;
    NSInteger _selectCategory;
    BOOL _showKeyboard;
}
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordhineTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UILabel *categoryLable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabe;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIView *showHelpView;
- (IBAction)saveAction:(id)sender;
- (IBAction)categoryAction:(id)sender;
- (IBAction)passwordAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
@end

@implementation DetailViewController


/*
-(void)aciton:(id)sender{
    UIButton *button = sender;
    //    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    //    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    anim.fromValue = @(0.0);
    //    anim.toValue = @(1.0);
    //    [view pop_addAnimation:anim forKey:@"fade"];
    
    //    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    //    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 400, 400)];
    //    anim.springSpeed = 0.1;
    //
    //    [view.layer pop_addAnimation:anim forKey:@"size"];
    
    
    POPSpringAnimation *anim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim2.toValue = [NSValue valueWithCGRect:CGRectMake(100, 100, 200, 200)];
    anim2.springSpeed = 0.1;
    [button.layer pop_addAnimation:anim2 forKey:@"sizew"];
}
 */


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    /*
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(aciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
     */
}



-(void)drawRect:(CGRect)rect {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[_scrollView setFrame:CGRectMake(0, 0, 200, 300)];
    //NSLog(@"height:%f",_scrollView.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [self setTextValue];
    if (_details) {
        [self changeEditWith:NO];
    }else{
        [self changeEditWith:YES];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryAction:)];
    [_categoryIcon addGestureRecognizer:tap];
    
    _showHelpView.hidden = YES;
    _titleTextField.delegate = self;
    _usernameTextField.delegate = self;
    _passwordTextField.delegate = self;
    _passwordhineTextField.delegate = self;
    _emailTextField.delegate = self;
    _noteTextField.delegate = self;
    _passwordTextField.secureTextEntry=NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = _details?@"Detail":@"Add";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _scrollView.bounces = YES;
    _contentViewWidth.constant  = self.view.frame.size.width;
    _contentViewHeight.constant = self.view.frame.size.height<500?self.view.frame.size.height+20:self.view.frame.size.height;
    NSLog(@"height : %f",self.view.frame.size.height);
}


- (void)hiddenKeyboard{
    [_titleTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeEditWith:(BOOL)enabled
{
    _categoryIcon.userInteractionEnabled = enabled;
    _saveButton.title = enabled?@"Save":@"Edit";
    _categoryButton.hidden = !enabled;
    _deleteButton.hidden = enabled;
    _titleTextField.enabled = enabled;
    _usernameTextField.enabled = enabled;
    _passwordTextField.enabled = enabled;
    _passwordhineTextField.enabled = enabled;
    _emailTextField.enabled = enabled;
    _noteTextField.enabled = enabled;
}



-(void)setTextValue
{
    if (![_details.title isEqual:@""] && _details.title) {
        _saveButton.enabled = YES;
        _titleTextField.text = _details.title;
    }else{
        _saveButton.enabled = NO;
        _titleTextField.placeholder = @"Title";
    }
    if (![_details.username isEqual:@""] && _details.username) {
        _usernameTextField.text = _details.username;
    }else{
        _usernameTextField.placeholder = @"Username";
    }
    if (![_details.password isEqual:@""] && _details.password) {
        _passwordTextField.text = _details.password;
    }else{
        _passwordTextField.placeholder = @"Password";
    }
    if (![_details.passwordhine isEqual:@""] && _details.passwordhine) {
        _passwordhineTextField.text = _details.passwordhine;
    }else{
        _passwordhineTextField.placeholder = @"Password hint";
    }
    if (![_details.email isEqual:@""] && _details.email) {
        _emailTextField.text = _details.email;
    }else{
        _emailTextField.placeholder = @"Email";
    }
    if (![_details.notes isEqual:@""] && _details.notes) {
        _noteTextField.text = _details.notes;
    }else{
        _noteTextField.placeholder = @"Notes";
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    _categoryData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    if (_details != nil ) {
        _selectCategory = _details.category;
        _categoryLable.text = _categoryTitleLabe.text = [_categoryData objectAtIndex:_details.category];
        _categoryIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)_details.category]];
    }else{
        if (_categoryId >=0 ) {
            _selectCategory = _categoryId;
            _categoryLable.text = _categoryTitleLabe.text = [_categoryData objectAtIndex:_categoryId];
            _categoryIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)_categoryId]];
        }else{
            _selectCategory = 8;
            _categoryLable.text = _categoryTitleLabe.text = [_categoryData objectAtIndex:8];
            _categoryIcon.image = [UIImage imageNamed:@"icon_8"];
        }
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

- (IBAction)saveAction:(id)sender
{
    if (_titleTextField.enabled) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_titleTextField.text,@"title",_usernameTextField.text,@"username",_passwordTextField.text,@"password",_passwordhineTextField.text,@"passwordhine",_emailTextField.text,@"email",_noteTextField.text,@"notes",@(_selectCategory),@"category", nil];
        if (_details) {
            [[PrivateDB sharedInstance] updateWith:dict index:_details.rid];
        }else{
            [[PrivateDB sharedInstance] insertWith:dict];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self changeEditWith:YES];
        [_titleTextField becomeFirstResponder];
    }
}

- (IBAction)categoryAction:(id)sender
{
    //[self hiddenKeyboard];
    ModalViewController *modalViewController = [ModalViewController new];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:modalViewController
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(ModalViewController *)dismissed
{
    NSLog(@"%ld",(long)dismissed.row);
    if (dismissed.row >= 0) {
        _details.category = _selectCategory = dismissed.row;
        _categoryIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",(long)dismissed.row]];
        _categoryLable.text = _categoryTitleLabe.text = [_categoryData objectAtIndex:_selectCategory];
    }
    return [DismissingAnimator new];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _titleTextField) {
        if (range.location>0) {
            _saveButton.enabled = YES;
        }else{
            if (![string isEqualToString:@""]) {
                _saveButton.enabled = YES;
            }else{
                _saveButton.enabled = NO;
            }
        }
    }
    return YES;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_showKeyboard) {
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width,_scrollView.contentSize.height+KEYBOARD);
        _showKeyboard = YES;
    }
    
    if (textField == _noteTextField && _scrollView.contentOffset.y<50) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollView setContentOffset:CGPointMake(0, 230)];
        }];
    }
    return  YES;
}


- (IBAction)passwordAction:(id)sender
{
    UIButton *button = sender;
    button.selected = !button.selected;
    _showHelpView.hidden = !_showHelpView.hidden;
    //_passwordTextField.secureTextEntry=!_passwordTextField.secureTextEntry;
}

- (IBAction)deleteAction:(id)sender
{
    [[PrivateDB sharedInstance] deleteWithIndex:_details.rid];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

