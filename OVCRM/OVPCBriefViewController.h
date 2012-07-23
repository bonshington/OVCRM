//
//  OVPCBriefViewController.h
//  OVCRM
//
//  Created by Warat Agatwipat on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVPCBriefViewController : UIViewController{
    NSString * planId;
    NSString * accountId;
}


@property (strong, nonatomic)NSArray * tempData;
@property (strong, nonatomic)NSMutableArray * pcbdata;
@property (nonatomic, strong)NSMutableDictionary *pcbrief;
@property (strong, nonatomic)NSString * pcb_id; 

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;


@property (strong, nonatomic) IBOutlet UITextView *textfeedback;
@property (strong, nonatomic) IBOutlet UITextView *textdisplayInfo;
@property (strong, nonatomic) IBOutlet UITextView *textpricingInfo;
@property (strong, nonatomic) IBOutlet UITextView *textofftakeInfo;

@end
