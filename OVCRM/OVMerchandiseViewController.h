//
//  OVMerchandiseViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"
#import "SFStepActionProtocal.h"


@interface OVMerchandiseViewController : OVProductConsumerController{

}

@property (nonatomic, retain) NSMutableDictionary *data;

-(void) load;

@end



@interface OVMerchandiseViewController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

@end


@interface OVMerchandiseViewController (Action)<SFStepActionProtocal>


@end