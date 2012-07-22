//
//  NSIndexPath+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "NSIndexPath+Extension.h"

@implementation NSIndexPath (Extension)

-(NSString *) toString{
	return [NSString stringWithFormat:@"%d-%d", self.section, self.row];
}

@end
