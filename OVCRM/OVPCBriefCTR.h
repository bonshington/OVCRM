//
//  OVPCBriefCTR.h
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVPCBriefCTR : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
NSString * planId;
NSString * accountId;
}


@property (strong, nonatomic)NSArray * tempData;
@property (strong, nonatomic)NSMutableArray * pcbdata;
@property (nonatomic, strong)NSMutableDictionary *pcbrief;
@property (strong, nonatomic)NSString * pcb_id; 

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;

@property (strong, nonatomic) IBOutlet UITableView *tableDataView;
@property (strong, nonatomic) IBOutlet UITextView *textviewPC;
@property (strong, nonatomic) IBOutlet UITextView *textDisplay;
@property (strong, nonatomic) IBOutlet UITextView *textPricing;
@property (strong, nonatomic) IBOutlet UITextView *textOfftake;


@end
