//
//  JMFormViewParametersViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 11/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewParametersViewController.h"

#import "JMFormScrollView.h"
#import "JMFormViews.h"
#import "JMDemoParameters.h"
#import "JMFormDescription.h"

#import "JMFormListSelectionTableViewController.h"

@interface JMFormViewParametersViewController ()
@property (weak, nonatomic) IBOutlet JMFormScrollView *formScrollView;
@property (strong, nonatomic) JMDemoParameters *formModel;
@property (strong, nonatomic) JMFormDescription *formDescription;
@end

@implementation JMFormViewParametersViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Complete your model
    self.formModel = [JMDemoParameters new];
    self.formScrollView.formViewSpace = 1.0f;
    
    self.formModel.availableColors = @[@"blue",@"red", @"grey"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //generate Layout description
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)reloadContent
{
    self.formDescription = [self generateFormDescriptionBlocksUsingModel:self.formModel];
    [self.formScrollView reloadScrollViewWithFormDescription:self.formDescription.formViewDescriptions];
}

- (void)presentListChoices:(NSArray *)choices currentChoice:(id)currentChoice withCompletionBlock:(JMFormViewCompltionBlock)block
{
    JMFormListSelectionTableViewController *listVc = [JMFormListSelectionTableViewController new];
    listVc.values = choices;
    listVc.completionBlock = block;
    [self.navigationController pushViewController:listVc animated:YES];
}

- (JMFormDescription *)generateFormDescriptionBlocksUsingModel:(JMDemoParameters *)model
{
    JMFormDescription *formDesc = [JMFormDescription new];
    NSMutableArray *descriptions = [NSMutableArray new];
    
    JMFormSectionHeaderFormViewDescription *headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Configuration";
    [descriptions addObject:headerDesc];
    
    JMListFormViewDescription *listDesc = [JMListFormViewDescription new];
    listDesc.title = @"FormView background color";
    listDesc.choices = @[@"blue", @"red", @"green"];
    listDesc.placeholder = @"none";
    listDesc.data = model.formViewBackgroundColor;
    listDesc.listStyle = JMListFormViewAppleInlinePush;
    listDesc.formViewHeight = 41.0f;
    listDesc.updateBlock = ^(id modifiedValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentListChoices:model.availableColors currentChoice:model.formViewBackgroundColor withCompletionBlock:^(id modifiedValue) {
                model.formViewBackgroundColor = modifiedValue;
                [self reloadContent];
            }];
        });
    };
    [descriptions addObject:listDesc];
    
    JMButtonFormViewDescription *buttonDesc = [JMButtonFormViewDescription new];
    buttonDesc.formDelegate = self;
    buttonDesc.title = @"This is a validation button";
    buttonDesc.formViewHeight = 50.0f;
    [descriptions addObject:buttonDesc];
    
    formDesc.formViewDescriptions = descriptions;
    return formDesc;
}

@end
