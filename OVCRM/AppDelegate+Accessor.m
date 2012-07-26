//
//  AppDelegate+Accessor.m
//  OVCRM
//
//  Created by Apple on 26/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

static NSArray *_product;
static NSDictionary *_indexing;
static NSDictionary *_sellable;
static NSDictionary *_pricebook;

@implementation AppDelegate (Accessor)

-(NSArray *)getProduct{
	return _product;
}

-(void) setProduct:(NSArray *)prod{
	_product = prod;
	
	if(prod == nil)
		_indexing = nil;
	else{
		_indexing = [prod dictionaryFromObjectForKey:@"Id"];
	}
}

-(NSDictionary *)getIndexing{
	return _indexing;
}


-(NSDictionary *)getSelleable{
	return _sellable;
}

-(void) setSelleablet:(NSDictionary *)val{
	_sellable = val;
}

@end
