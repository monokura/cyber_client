//
//  CandyTableViewController.m
//  CandySearch
//
//  Created by Nicolas Martin on 7/5/12.
//  Copyright (c) 2012 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "search_group.h"
#import "group_database.h"

@interface search_group ()

@end

@implementation search_group
@synthesize groupArray;
@synthesize filteredgroupArray;
@synthesize serchbar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Don't show the scope bar or cancel button until editing begins
    [_groupSerchBar setShowsScopeBar:NO];
    [_groupSerchBar sizeToFit];
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + _groupSerchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    /*** Sample Data for candyArray ***/
    
    groupArray = [NSArray arrayWithObjects:
                  [group_database groupOfCategory:@"chocolate" name:@"chocolate bar"],
                  [group_database groupOfCategory:@"chocolate" name:@"chocolate chip"],
                  [group_database groupOfCategory:@"chocolate" name:@"dark chocolate"],
                  [group_database groupOfCategory:@"hard" name:@"lollipop"],
                  [group_database groupOfCategory:@"hard" name:@"candy cane"],
                  [group_database groupOfCategory:@"hard" name:@"jaw breaker"],
                  [group_database groupOfCategory:@"other" name:@"caramel"],
                  [group_database groupOfCategory:@"other" name:@"sour chew"],
                  [group_database groupOfCategory:@"other" name:@"peanut butter cup"],
                  [group_database groupOfCategory:@"other" name:@"gummi bear"], nil];
    
    // Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    filteredgroupArray = [NSMutableArray arrayWithCapacity:[groupArray count]];
    
    // Reload the table
    [[self tableView] reloadData];
    
    
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredgroupArray count];
    }
	else
	{
        return [groupArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Create a new Candy Object
    group_database *group = nil;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        group = [filteredgroupArray objectAtIndex:[indexPath row]];
    }
	else
	{
        group = [groupArray objectAtIndex:[indexPath row]];
    }
    
    // Configure the cell
    [[cell textLabel] setText:[group name]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"candyDetail" sender:tableView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"candyDetail"] ) {
        UIViewController *candyDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[filteredgroupArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[groupArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
        
    }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredgroupArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [groupArray filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    filteredgroupArray = [NSMutableArray arrayWithArray:tempArray];
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [serchbar becomeFirstResponder];
}



















@end
