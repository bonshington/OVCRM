//
//  OVLandingController.m
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVLandingController.h"
#import "AppDelegate.h"
#import "RootViewController.h"



@implementation OVLandingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    
    app.window.rootViewController = [RootViewController new];
    
    //[self.parentViewController dismissViewControllerAnimated:animated completion:nil];
    
    //[self dismissModal:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    
}

-(IBAction)dismissModal:(id)sender{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    
    app.window.rootViewController = [RootViewController new];

}

@end
