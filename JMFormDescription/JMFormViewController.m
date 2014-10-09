//
//  JMFormViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController.h"
#import "JMFormViewController+formDescriptionUsingBlocks.h"

#import "JMFormListSelectionTableViewController.h"

#import "JMFormScrollView.h"
#import "JMFormViews.h"
#import "JMFormModel.h"

@interface JMFormViewController ()
@property (weak, nonatomic) IBOutlet JMFormScrollView *formScrollView;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //generate Layout description
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)reloadContent
{
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)presentChoices
{
    
}

#pragma mark - JMFormDelegate


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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

@end
