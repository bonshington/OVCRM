//
//  OVGoodReturnViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"


@interface OVGoodReturnViewController : OVProductConsumerController

@property(nonatomic, retain) NSDictionary *data;

@end



@interface OVGoodReturnViewController (Action)<SFStepActionProtocal>


@end



@interface OVGoodReturnViewController (UITableViewHandler)

@end