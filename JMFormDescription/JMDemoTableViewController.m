//
//  JMDemoTableViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 09/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMDemoTableViewController.h"
#import "JMDemoTableViewCell.h"

#import "JMFormViewController.h"
#import "JMFormViewController2.h"

#import "JMFormScrollView.h"
#import "JMFormViews.h"

@implementation JMDemoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JMFormView demo";
    
    /*
    [[JMFormScrollView appearance] setFormViewSpace:0.0f];
    [[JMFormView appearance] setFormViewBackgroundColor:[UIColor colorWithRed:219.0/255 green:214.0/255 blue:208/255 alpha:1.0]];
    [[JMTextfieldFormView appearance] setFormViewTextfieldFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:16.0f]];
    [[JMTextfieldFormView appearance] setFormViewTextfieldTextColor:[UIColor blackColor]];
    
    [[JMTextfieldWithTitleFormView appearance] setFormViewTitleFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]];
    [[JMFormSectionHeaderFormView appearance] setFormViewHeaderLabelFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:25.0f]];
    [[JMFormSectionHeaderFormView appearance] setFormViewHeaderBackgroundColor:[UIColor whiteColor]];
    
    [[JMButtonFormView appearance] setFormViewButtonTitleColor:[UIColor whiteColor]];
    [[JMButtonFormView appearance] setFormViewButtonBackgroundColor:[UIColor blackColor]];
    [[JMButtonFormView appearance] setFormViewButtonTitleFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:16.0f]];
    
    [[JMSwitchFormView appearance] setFormViewTitleFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:15.0f]];
    [[JMSwitchFormView appearance] setFormViewSwitchTintColor:[UIColor purpleColor]];
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (JMDemoTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMDemoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"JMDemoTableViewCell"];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"Demo with delegates";
        cell.demoTextLabel.text = @"This implementation use forView Delegates methods to synchronize model and formViews.";
        
    } else {
        cell.titleLabel.text = @"Demo with blocks";
        cell.demoTextLabel.text = @"This implementation use blocks to synchronize model and formViews.";    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JMFormViewController2 *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMFormViewController2"];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        JMFormViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JMFormViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
