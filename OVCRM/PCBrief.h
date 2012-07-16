//
//  PCBrief.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class tblSaleTalk;
@class tblPCBrief;

@interface PCBrief : UIViewController
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * account_ID;

@property (strong, nonatomic) tblSaleTalk * tblsaleTalk;
@property (strong, nonatomic) tblPCBrief * tblpcBrief;

@property (strong, nonatomic) IBOutlet UITextView *textSalesTalk;
@property (strong, nonatomic) IBOutlet UILabel *lblPCBrief;
@property (strong, nonatomic) IBOutlet UITextView *textPCBrief;
-(void) setSalesTalkPage;
-(void) setPCBriefPage;

-(void) saveDataSaleTalk;
-(void) saveDataPCBrief;


@end
