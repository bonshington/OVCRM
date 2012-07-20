//
//  OVStepsController.h
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVStepsController : UINavigationController

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;

-(id) initWithPlanId:(NSString *)_planId accountId:(NSString *)_accountId;

@end
