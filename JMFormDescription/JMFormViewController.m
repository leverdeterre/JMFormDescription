//
//  JMFormViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController.h"
#import "JMFormViewController+formDescriptionUsingBlocks.h"
#import "JMFormScrollView.h"
#import "JMFormViews.h"

#import "JMFormModel.h"
#import "UIViewController+MaryPopin.h"
#import "JMFormListSelectionTableViewController.h"
#import "JMFormViewParametersViewController.h"

@interface JMFormViewController () <JMFormDatasource>
@property (strong, nonatomic) JMFormModel *formModel;
@property (strong, nonatomic) JMFormDescription *formDescription;
@end

@implementation JMFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Complete your model
    self.formModel = [JMFormModel new];
    self.formModel.coloChoices = @[@"blue",@"red", @"grey"];
    self.formModel.listPlaceholder = @"choose a color";
    self.formModel.textfieldText1 = @"test";
    
    self.title = @"JMFormView blocks";
    self.formScrollView.formViewSpace = 1.0f;
    
    UIBarButtonItem *ri = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(configureScrollFormView:)];
    self.navigationItem.rightBarButtonItem = ri;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //generate Layout description
    self.formScrollView.formViewDatasource = self;
    [self reloadContent];
}

- (void)reloadContent
{
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadData];
}

- (void)presentChoices
{
    
}

#pragma mark - JMFormDelegate

#pragma mark - JMFormDatasource

- (NSInteger)formScrollView:(JMFormScrollView *)formScrollView numberOfRowsInSection:(NSInteger)section
{
    return self.formDescription.formViewDescriptions.count;
}

- (JMFormView *)formScrollView:(JMFormScrollView *)formScrollView formViewForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMFormViewDescription *desc = [self.formDescription.formViewDescriptions objectAtIndex:indexPath.row];
    JMFormView *formView = [desc.formViewClass viewFromNib];
    [formView updateFormViewWithDescription:desc];
    return formView;
}

#pragma mark - JMListFormView delegate full demos

- (void)presentListChoices:(NSArray *)choices currentChoice:(id)currentChoice withCompletionBlock:(JMFormViewCompltionBlock)block
{
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    listVc.values = choices;
    listVc.completionBlock = block;
    UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:listVc];
    [self presentViewController:nacV animated:YES completion:NULL];
}

- (void)scrollToFormView:(JMFormView *)formView
{
    [self.formScrollView scrollRectToVisible:formView.frame animated:YES];
}

#pragma mark - Keyboard ...

- (BOOL)nextFormViewAvailableAfterFormView:(JMFormView *)formView
{
    JMFormView *nextForm = [self.formScrollView nextFirstResponderFormViewFromView:formView];
    return nextForm!=nil;
}

- (BOOL)previousFormViewAvailableBeforeFormView:(JMFormView *)formView
{
    JMFormView *previousForm = [self.formScrollView previousFirstResponderFormViewFromView:formView];
    return previousForm!=nil;
}

- (void)presentNextFormViewAvailableAfterFormView:(JMFormView *)formView
{
    JMFormView *nextForm = [self.formScrollView nextFirstResponderFormViewFromView:formView];
    [nextForm formViewBecomeFirstResponder];
}

- (void)presentPreviousFormViewAvailableBeforeFormView:(JMFormView *)formView
{
    JMFormView *previousForm = [self.formScrollView previousFirstResponderFormViewFromView:formView];
    [previousForm formViewBecomeFirstResponder];
}

#pragma mark - IBactions

- (IBAction)customSelector1:(id)sender
{
    [self.view endEditing:NO];
    NSLog(@"%s",__FUNCTION__);
}

- (IBAction)configureScrollFormView:(id)sender
{
    JMFormViewParametersViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMFormViewParametersViewController"];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    navc.preferedPopinContentSize = CGSizeMake(280.0f, [UIScreen mainScreen].bounds.size.height - 100.f);
    navc.popinOptions = BKTPopinBlurryDimmingView;
    navc.navigationBarHidden = YES;
    [self.navigationController presentPopinController:navc animated:YES completion:NULL];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

@end
