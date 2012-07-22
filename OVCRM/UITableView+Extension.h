//
//  UITableView+Extension.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)

-(UITableViewCell *)selectedCell;
-(UILabel *)labelInSelectdCellWithTag:(int)tag;
-(UIView *) viewWithTag:(NSInteger)tag forRow:(NSInteger)row inSection:(NSInteger)section;

@end
