//
//  OVCompetitiveCTR.h
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVCompetitiveCTR : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSString * planID;
    NSString * accountID;
}

@property (strong, nonatomic) NSString * planID;
@property (strong, nonatomic) NSString * accountID;

@property (strong, nonatomic)NSArray * tempData;
@property (strong, nonatomic)NSMutableArray * comacdata;
@property (nonatomic, strong)NSMutableDictionary *competitive;
@property (strong, nonatomic)NSString * compat_id; 


@property (strong, nonatomic) IBOutlet UITableView *tableDataView;
@property (strong, nonatomic) IBOutlet UITextView *textProduct;
@property (strong, nonatomic) IBOutlet UITextView *textCompany;
@property (strong, nonatomic) IBOutlet UITextView *textIFeb;
@property (strong, nonatomic) IBOutlet UITextView *textPromotion;

@end
