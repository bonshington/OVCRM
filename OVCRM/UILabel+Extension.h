//
//  UILabel+Extension.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+(id) hiddenLabelForText:(NSString *)text withTag:(int)tag;
+(UILabel *) labelWithRect:(CGRect)rect tag:(int)tag text:(NSString *)text;

@end
