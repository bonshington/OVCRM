//
//  UITableView+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

-(UITableViewCell *)selectedCell{
	
	return [self cellForRowAtIndexPath:[self indexPathForSelectedRow]];
}

-(UILabel *)labelInSelectdCellWithTag:(int)tag{
	return (UILabel *)[[self selectedCell] viewWithTag:tag];
}

-(UIView *) viewWithTag:(NSInteger)tag forRow:(NSInteger)row inSection:(NSInteger)section{
	return[[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]] viewWithTag:tag];
}

-(void) deselectAllRows{
	[self.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(NSIndexPath *each, NSUInteger index, BOOL *stop){
		[self deselectRowAtIndexPath:each animated:YES];
	}];
}

@end
