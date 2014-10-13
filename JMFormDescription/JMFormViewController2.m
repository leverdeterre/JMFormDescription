//
//  JMFormViewController2.m
//  JMFormDescription
//
//  Created by jerome morissard on 09/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController2.h"
#import "JMFormViewController2+formDescriptionUsingDelegates.h"

#import "JMFormListSelectionTableViewController.h"

#import "JMFormDescriptions.h"
#import "JMFormModel.h"

@interface JMFormViewController2 ()
@property (weak, nonatomic) IBOutlet JMFormScrollView *formScrollView;
@property (strong, nonatomic) JMFormModel *formModel;
@property (strong, nonatomic) JMFormDescription *formDescription;
@end

@implementation JMFormViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Complete your model
    self.formModel = [JMFormModel new];
    self.formModel.coloChoices = @[@"blue",@"red", @"grey"];
    self.formModel.listPlaceholder = @"choose a color";
    self.formModel.textfieldText1 = @"test";
    
    self.title = @"JMFormView delegates";
    self.formScrollView.formViewSpace = 1.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //generate Layout description
    self.formDescription = [self generateFormDescriptionUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)reloadContent
{
    self.formDescription = [self generateFormDescriptionUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)presentChoices
{
    
}

#pragma mark - JMFormDelegate

- (void)textUpdatedFromFormView:(JMTextfieldFormView *)formView textfield:(UITextField *)textfield toText:(NSString *)text
{
    NSLog(@"%@ change text to %@",formView,text);
    NSInteger index = [self.formScrollView indexForFormView:formView];
    NSString *modelKey = [self.formDescription modelKeyForDescriptionAtIndex:index];
    [self.formModel setValue:text forKey:modelKey];
}

- (void)textUpdatedFromFormView:(JMTextViewFormView *)formView textView:(UITextView *)textView toText:(NSString *)text
{
    NSLog(@"%@ change text to %@",formView,text);
    NSInteger index = [self.formScrollView indexForFormView:formView];
    NSString *modelKey = [self.formDescription modelKeyForDescriptionAtIndex:index];
    [self.formModel setValue:text forKey:modelKey];
}

- (void)switchChangedFromFormView:(JMSwitchFormView *)formView toValue:(BOOL)value
{
    NSLog(@"%@ change switch to %d",formView,value);
    [self.view endEditing:NO];
    NSInteger index = [self.formScrollView indexForFormView:formView];
    NSString *modelKey = [self.formDescription modelKeyForDescriptionAtIndex:index];
    [self.formModel setValue:@(value) forKey:modelKey];
    [self reloadContent];
}

- (void)buttonPressedFromFormView:(JMButtonFormView *)formView withTitleValue:(NSString *)value
{
    NSLog(@"%@ button Pressed to %@",formView,value);
    [self.view endEditing:NO];
}

#pragma mark - JMListFormView delegate full demos

- (void)listPressedFromFormView:(JMListFormView *)formView withSelectedValue:(NSString *)value
{
    NSLog(@"%@ listPressedFromCell Pressed to %@",formView,value);
    NSInteger index = [self.formScrollView indexForFormView:formView];
    [self.view endEditing:NO];
    
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    JMListFormViewDescription *desc = [self.formDescription.formViewDescriptions objectAtIndex:index];
    listVc.values = desc.choices;
    listVc.formDelegate = self;
    listVc.modelKey = desc.modelKey;
    listVc.title = desc.title;
    
    if (formView.listStyle == JMListFormViewModalChoice) {
        UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:listVc];
        [self presentViewController:nacV animated:YES completion:NULL];
    } else {
        [self.navigationController pushViewController:listVc animated:YES];
    }
}

- (void)dismissWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey
{
    [self.view endEditing:NO];
    [self.formModel setValue:currentChoice forKeyPath:modelKey];
    [self dismissViewControllerAnimated:YES completion:^{
        [self reloadContent];
    }];
}

- (void)presentListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice
{
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    listVc.values = choices;
    listVc.formDelegate = self;
    listVc.modelKey = modelKey;
    //listVc.title = title;
    UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:listVc];
    [self presentViewController:nacV animated:YES completion:NULL];
}

- (void)pushListChoices:(NSArray *)choices forModelKey:(NSString *)modelKey currentChoice:(id)currentChoice
{
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    listVc.values = choices;
    listVc.formDelegate = self;
    listVc.modelKey = modelKey;
    [self.navigationController pushViewController:listVc animated:YES];
}

- (void)popWithChoice:(id)currentChoice forModelKey:(NSString *)modelKey
{
    [self.formModel setValue:currentChoice forKeyPath:modelKey];
    [self reloadContent];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

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
    self.formDescription = [self generateFormDescriptionUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

@end
