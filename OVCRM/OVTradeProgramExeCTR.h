//
//  OVTradeProgramExeCTR.h
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVTradeProgramExeCTR : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSString * planId;
    NSString * accountId;
}

@property (strong, nonatomic)NSArray * tempData;
@property (strong, nonatomic)NSMutableArray * tradedata;
@property (nonatomic, strong)NSMutableDictionary *tradeprogram;
@property (strong, nonatomic)NSString * trade_id; 

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;

@property (strong, nonatomic) IBOutlet UITextView * textTradeProgramResult;

@end
