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

#import "AppDelegate.h"
#import "RootViewController.h"
#import "SFIdentityData.h"

#import "OVLandingController.h"


/*
 NOTE if you ever need to update these, you can obtain them from your Salesforce org,
 (When you are logged in as an org administrator, go to Setup -> Develop -> Remote Access -> New )
 */


// Fill these in when creating a new Remote Access client on Force.com 
static NSString *const RemoteAccessConsumerKey = @"3MVG9Nvmjd9lcjRkRMXLy_Kh3EyvDLt4eLkHn8Hy8VpJM4ZmyUE2cZFD0CqXTP907zsMYo_3YDG2VFiLJElMX";
static NSString *const OAuthRedirectURI = @"testsfdc:///mobilesdk/detect/oauth/done";
//OVCRM:///mobilesdk/detect/oauth/done
//testsfdc:///mobilesdk/detect/oauth/done


@implementation AppDelegate

@synthesize db, root, master, detail, sync, user, registeredUploadStatusChange, location, locationManager, sqlFormat;

SFIdentityCoordinator *_coordinator;

+(AppDelegate *) sharedInstance{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Remote Access / OAuth configuration


- (NSString*)remoteAccessConsumerKey {
    return RemoteAccessConsumerKey;
}

- (NSString*)oauthRedirectURI {
    return OAuthRedirectURI;
}


#pragma mark - Upload Process

-(void) registerUploadTaskChange:(id<OVUploadProtocal>)control{
	
	if(self.registeredUploadStatusChange == nil)
		self.registeredUploadStatusChange = [NSMutableArray new];
	
	[self.registeredUploadStatusChange addObject:control];
}

-(int) refreshUploadTask{
	
	FMResultSet *result = [self.db executeQuery:@"select count(*) from Upload where syncTime is null"];
	
	[result next];
	
	int left = [result intForColumnIndex:0];
	
	[result close];
	
	if(self.registeredUploadStatusChange != nil){
		[self.registeredUploadStatusChange enumerateObjectsUsingBlock:^(id<OVUploadProtocal> control, NSUInteger index, BOOL *stop){
			[control updateUploadStatus:left];
		}];
	}
	
	return left;
}

-(void) updateUploadStatus:(int)tasksLeft{
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = tasksLeft;
}


#pragma mark - App lifecycle


//NOTE be sure to call all super methods you override.


- (UIViewController*)newRootViewController {
    
	/* Setup location system */
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	self.locationManager.distanceFilter = kCLDistanceFilterNone; 
	[self.locationManager startUpdatingLocation];
	
	self.location = [self.locationManager location];
	
	
	[self registerUploadTaskChange:self];
	
	
	//SFIdentityCoordinator retrieve user data
	
	[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
	
	return [OVLandingController new];
}


#pragma mark - screen handling

- (void)applicationDidBecomeActive:(UIApplication *)application{
	
	// init date Format
	self.sqlFormat = [NSDateFormatter new];
    [self.sqlFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
	
	[super applicationDidBecomeActive:application];
	
	if(self.db != nil && !self.db.open){
		[self.db open];
	}
	
	
	
	if([super respondsToSelector:@selector(applicationDidBecomeActive:)])
		[super applicationDidBecomeActive:application];
	
	if(self.master != nil)
		[self.master reloadData];
	
}

/*
- (void)applicationWillResignActive:(UIApplication *)application{
	
	if(self.db.open){
		[self.db closeOpenResultSets];
		[self.db close];
	}
	
	if([super respondsToSelector:@selector(applicationWillResignActive:)])
		[super applicationWillResignActive:application];
}
*/

-(NSDictionary *)getUser{

	return [NSMutableDictionary dictionaryWithObjectsAndKeys:
			@"10390230", @"route",
			@"", @"userId",
			[[[self.db executeQuery:@"select label from Parameter where tag = 'CONFIG' and key = 'LAST_SYNC'"] readToEnd] objectAtIndex:0 forKey:@"label"], @"lastSyncDate", 
			[NSString stringWithFormat:@"%f", self.location.coordinate.latitude], @"lat",
			[NSString stringWithFormat:@"%f", self.location.coordinate.longitude], @"lng",
			nil];
}

#pragma mark - CLLocationManager

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{

	self.location = newLocation;
}

@end
