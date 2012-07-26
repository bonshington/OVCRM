//
//  UITextField+Extension.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/20/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

+(id) newWithCGRect:(CGRect)rect tag:(NSInteger)tag text:(NSString *)text respondTo:(id)obj selector:(SEL)sel;
+(id) newWithCGRect:(CGRect)rect tag:(NSInteger)tag number:(NSString *)text respondTo:(id)obj selector:(SEL)sel;

@end
