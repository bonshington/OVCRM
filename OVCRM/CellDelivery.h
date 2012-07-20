//
//  CellDelivery.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDelivery : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productDetail;
@property (strong, nonatomic) IBOutlet UILabel *fullPrice;
@property (strong, nonatomic) IBOutlet UITextField *quantity;
@property (strong, nonatomic) IBOutlet UILabel *amount;
@property (strong, nonatomic) IBOutlet UILabel *discount;
@property (strong, nonatomic) IBOutlet UILabel *totalAmount;

@end
