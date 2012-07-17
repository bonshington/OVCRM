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


#import <CoreLocation/CLLocationManager.h>
#import "SFNativeRestAppDelegate.h"
#import "FMDatabase.h"
#import "OVDatabase.h"
#import "sObject.h"
#import "Constant.h"
#import "FMResultSet+Extension.h"
#import "NSString+Extension.h"
#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSDictionary+NullHandling.h"
#import "NSMutableDictionary+Extension.h"
#import "Constant.h"
#import "OVUploadProtocal.h"
#import "UITableView+Extension.h"
#import "UILabel+Extension.h"
#import "SFJsonUtils.h"
#import "NSDate+Extension.h"

@interface AppDelegate : SFNativeRestAppDelegate <OVUploadProtocal, CLLocationManagerDelegate>{

}

@property (nonatomic, copy, getter = getUser) NSDictionary *user;
@property (nonatomic, retain) UIViewController *master;
@property (nonatomic, retain) UINavigationController *detail;
@property (nonatomic, retain) OVDatabase *db;
@property (nonatomic, retain) id<SFRestDelegate> sync;
@property (nonatomic, retain) NSMutableArray *registeredUploadStatusChange;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(SFIdentityData *) getIdentity;

-(void) registerUploadTaskChange:(id<OVUploadProtocal>)control;
-(int) refreshUploadTask;

+(AppDelegate *) sharedInstance;




@end

