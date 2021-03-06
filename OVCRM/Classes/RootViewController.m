/*
 Copyright (c) 2011, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "RootViewController.h"


#import "OVDetailController.h"
#import "OVMenuController.h"
#import "AppDelegate.h"
#import "OVDatabase.h"

@implementation RootViewController


- (id) init{
    
    NSLog(@"RootViewController:initWithNibName");
    
    self = [super init];
    if (self) {
        // Custom initialization
        self.presentsWithGesture = NO;
        
        // Load splitted parts
        AppDelegate *app = [AppDelegate sharedInstance];
        
        app.master = [[OVMenuController alloc] initWithNibName:@"OVMenuController" bundle:[NSBundle mainBundle]];
        app.detail = [[OVNavigationController alloc] init];
        app.db = [OVDatabase new];
        
        self.viewControllers = [NSArray arrayWithObjects:app.master, app.detail, nil];
    }
    return self;
}

#pragma mark Misc

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    NSLog(@"RootViewController:viewDidLoad");
    
    
    [super viewDidLoad];
    NSLog(@"RootViewController.super:viewDidLoad");
    
    
    self.title = @"Test Default";

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return (toInterfaceOrientation == UIDeviceOrientationLandscapeRight) || (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataRows count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *CellIdentifier = @"CellIdentifier";

   // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];

    }
	//if you want to add an image to your cell, here's how
	UIImage *image = [UIImage imageNamed:@"icon.png"];
	cell.imageView.image = image;

	// Configure the cell to show the data.
	NSDictionary *obj = [dataRows objectAtIndex:indexPath.row];
	cell.textLabel.text =  [obj objectForKey:@"Name"];

	//this adds the arrow to the right hand side.
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	return cell;

}
 */

@end
