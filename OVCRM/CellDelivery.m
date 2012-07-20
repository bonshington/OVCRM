//
//  CellDelivery.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "CellDelivery.h"

@implementation CellDelivery
@synthesize productName;
@synthesize productDetail;
@synthesize fullPrice;
@synthesize quantity;
@synthesize amount;
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

@end
