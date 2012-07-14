//
//  OVWebViewProtocal.h
//  OVCRM
//
//  Created by Apple on 13/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OVWebViewProtocal <NSObject>

@required

- (void) invokeSFObject:(NSString *)sObject 
		   withMustache:(NSDictionary *)data 
	 withRightBarButton:(UIBarButtonItem *)button;

@end
