//
//  JMFormListSelectionTableViewController.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormListSelectionTableViewController.h"

@interface JMFormListSelectionTableViewController ()

@end

@implementation JMFormListSelectionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.values.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    cell.textLabel.text = [self.values objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedValue = [self.values objectAtIndex:indexPath.row];
    if ([self.formDelegate respondsToSelector:@selector(dismissWithChoice:forModelKey:)]) {
        [self.formDelegate dismissWithChoice:selectedValue forModelKey:self.modelKey];
    }
}

@end
