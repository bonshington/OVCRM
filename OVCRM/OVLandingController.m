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
    
    // presented by SFRootViewController)
    if(self.parentViewController == nil){
        
        // dismiss modal, due to SplitViewController cannot be presented as Modal    
        [self dismissViewControllerAnimated:YES completion:^(void){
            
			[AppDelegate sharedInstance].root = [RootViewController new];
			
            [[AppDelegate sharedInstance].window setRootViewController:[AppDelegate sharedInstance].root];
            
        }];
    }
    
    // presented by OVRootViewController
    else{
        
        //Show landing page
        self.view.hidden = NO;
        self.title = @"Home";
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self dismissModal:nil];
}

-(IBAction)dismissModal:(id)sender{
    
    
}

@end
