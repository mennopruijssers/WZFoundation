//
//  WZSelectViewController.m
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "WZSelectViewController.h"

@interface WZSelectViewController ()
- (void) doneClicked;
- (void) cancelClicked;
@end

@implementation WZSelectViewController

@synthesize labels=_labels, values=_values, selectedValue, onComplete;

- (id)initWithLabels:(NSArray *)labels values:(NSArray *)values {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        _labels = labels;
        _values = values;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked)];
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)doneClicked {
    onComplete(self, [self selectedValue]);
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)cancelClicked {
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self labels] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *label = [[self labels] objectAtIndex:[indexPath row]];    
    [[cell textLabel] setText:label];
    
    if([[self values] objectAtIndex:[indexPath row]] == [self selectedValue]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *reloadPath = nil;

    if(selectedValue) {
        reloadPath = [NSIndexPath indexPathForRow:[[self values] indexOfObject:[self selectedValue]] inSection:[indexPath section]];        
        if([reloadPath row] == [indexPath row]) {
            reloadPath = nil;
        }
    }
    
    [self setSelectedValue:[[self values] objectAtIndex:[indexPath row]]];

    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, reloadPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
