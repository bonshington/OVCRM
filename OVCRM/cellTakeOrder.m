//
//  cellTakeOrder.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/11/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "cellTakeOrder.h"

@implementation cellTakeOrder
@synthesize productName;
@synthesize productDetail;
@synthesize Suggest;
@synthesize order;
@synthesize total;
@synthesize discount;
@synthesize totalAmount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//+ (NSString *)reuseIdentifier {    
//    return @"CustomCellIdentifier";
//}

@end
