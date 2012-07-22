//
//  OVCallCardController.h
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"


#define CC_UI_OFFSET_ON_SHELF	840
#define CC_UI_OFFSET_IN_STORE	930


#define CC_UI_OFFSET_INV		575
#define CC_UI_SPACE_INV			105

@interface OVCallCardController : OVProductConsumerController{

}


@property (nonatomic, retain) NSMutableDictionary *callcard;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSDictionary *history;

-(void) loadCallCard;
-(void) loadData;
-(void) loadHistory;


@end



@interface OVCallCardController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

-(void)tableViewCell:(UITableViewCell *)cell renderInputWith:(NSDictionary *)_data;
-(void)tableViewCell:(UITableViewCell *)cell renderLabelWith:(NSDictionary *)_data;

@end



@interface OVCallCardController (Action)<SFStepActionProtocal>


@end


