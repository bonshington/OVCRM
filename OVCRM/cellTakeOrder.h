//
//  cellTakeOrder.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/11/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellTakeOrder : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel * productName;
@property (strong, nonatomic) IBOutlet UILabel * productDetail;
@property (strong, nonatomic) IBOutlet UILabel * Suggest;
@property (strong, nonatomic) IBOutlet UILabel * total;
@property (strong, nonatomic) IBOutlet UILabel * discount;
@property (strong, nonatomic) IBOutlet UILabel * totalAmount;

@property (strong, nonatomic) IBOutlet UITextField * order;



@end
