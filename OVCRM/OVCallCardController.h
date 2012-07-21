//
//  OVCallCardController.h
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"
#import "SFStepActionProtocal.h"

#define CC_UI_OFFSET_ON_SHELF	415
#define CC_UI_OFFSET_IN_STORE	500


#define CC_UI_OFFSET_INV		575
#define CC_UI_SPACE_INV			105

@interface OVCallCardController : OVProductConsumerController{

}


@property (nonatomic, retain) NSMutableDictionary *callcard;
@property (nonatomic, retain) NSMutableDictionary *callcard_data;
@property (nonatomic, retain) NSDictionary *history;

-(void) loadCallCard;
-(void) loadCallCardData;
-(void) loadHistory;


@end



@interface OVCallCardController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

@end



@interface OVCallCardController (Action)<SFStepActionProtocal>


@end


