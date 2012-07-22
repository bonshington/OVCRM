//
//  SFStepActionProtocal.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SFStepActionProtocal <NSObject>

@required
-(IBAction)change:(id)sender;
-(IBAction)checkout:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)next:(id)sender;
//-(NSArray *)loadProducts;

@end
