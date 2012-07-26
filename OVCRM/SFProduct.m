//
//  SFProduct.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFProduct.h"
#import "AppDelegate.h"


@implementation SFProduct

#pragma mark - SFObjectProtocal

-(NSString *) sfName{ return @"Product_Database__c"; }
-(NSString *) sqlName{ return @"Product"; }

- (NSDictionary *)schema{
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"LOOKUP"	, @"CreatedBy",
			@"LOOKUP"	, @"LastModifiedBy",
			@"TEXT"		, @"Name",
			
			@"PICKLIST"	, @"Brand__c",
			@"PICKLIST"	, @"Class__c",
			@"NUMBER"	, @"Cost__c",
			@"TEXT"		, @"Description__c",
			@"TEXT"		, @"Discount_Sequence__c",
			@"TEXT"		, @"FOC_Code__c",
			@"NUMBER"	, @"Height__c",
			@"TEXT"		, @"INT_ActionType__c",
			@"PICKLIST"	, @"Is_Cancel__c",
			@"TEXT"		, @"Is_Free__c",
			@"DATETIME"	, @"Last_Modified__c",
			@"TEXT"		, @"List_Price__c",
			@"NUMBER"	, @"Long__c",
			@"TEXT"		, @"Main_Product__c",
			@"NUMBER"	, @"Maximum_Stock__c",
			@"TEXT"		, @"MD_Product_Category_Code__c",
			@"TEXT"		, @"MD_Product_Class_Code__c",
			@"TEXT"		, @"MD_Product_IsCancel_Code__c", // 2 means can do Call card. but whay about 1 and 0?
			@"TEXT"		, @"MD_Product_VatStatus_Code__c",
			@"TEXT"		, @"MD_Product_Group__c",
			@"NUMBER"	, @"Minimum_Stock__c",
			@"TEXT"		, @"No_Do__c",
			@"PICKLIST"	, @"Packaging__c",
			@"NUMBER"	, @"Pack_Size__c",
			@"TEXT"		, @"Product_Source__c",
			@"PICKLIST"	, @"Product_Category__c",
			@"TEXT"		, @"Product_Code__c",
			@"PICKLIST"	, @"Product_Family__c",
			@"PICKLIST"	, @"Product_Group__c",
			@"TEXT"		, @"Short_name__c",
			@"TEXT"		, @"Source_System__c",
			@"NUMBER"	, @"Target__c",
			@"TEXT"		, @"UnitName__c",
			@"PICKLIST"	, @"Vat_Status__c",
			@"NUMBER"	, @"Weight__c",
			@"NUMBER"	, @"Width__c", 
			nil];
	
}

-(NSDictionary *)mapping{
	
	//PK,sale_ID,product_Code,product_Name,lastSyncDate,lastSyncTime,cost,weight,packaging,width,packSize,productLong,height,product_Category,brand,shortName,product_Family,target,unitName,isCancel,Active_Flag,Expire_Flag
	
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"product_Code", @"Product_Code__c",
			@"product_Name", @"Name",
			//@"lastSyncDate", @"",
			//@"lastSyncTime", @"",
			@"cost"		, @"Cost__c",
			@"weight"	, @"Weight__c",
			@"packaging", @"Packaging__c",
			@"width"	, @"Width__c",
			@"packSize"	, @"Pack_Size__c",
			@"productLong", @"Long__c",
			@"height"	, @"Height__c",
			@"product_Category", @"Product_Category__c",
			@"brand"	, @"Brand__c",
			@"shortName", @"Short_name__c",
			@"product_Family", @"Product_Family__c",
			@"target"	, @"Target__c",
			@"unitName"	, @"UnitName__c",
			@"isCancel"	, @"Is_Cancel__c",
			
			// Q: Why 2 flags?
			@"Active_Flag", @"",
			@"Expire_Flag", @"",
			nil];
}



-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

+(NSArray *) availableProduct{
	return [[[OVDatabase sharedInstance] executeQuery:
			 @"select p.Id, p.product_Category, p.product_Code, p.packSize, p.weight, p.packaging, p.List_Price__c, p.product_Name, p.shortName \
			 from	Product p \
			 join	MD_Product_Category__c md \
			 on	md.Code__c = p.MD_Product_Category_Code__c \
			 where	p.Main_Product__c = '1' and p.isCancel <> 'Inactive' \
			 order by md.Runing_Number__c, p.MD_Product_IsCancel_Code__c"] readToEnd];
}

+(NSArray *) sellableForAccount:(NSString *)accountId{
	return [[[OVDatabase sharedInstance] executeQuery:
			 @"select * from Product__c  \
			 where	Price_Book__c in (select Id from Price_Book__c where Account__c = ? and Status__c = 'Sales ( Order Taking )' and Active__c = '1' and (Start_Date__c is null or Start_Date__c <= DATE('now')) and (End_Date__c is null or DATE('now') >= End_Date__c) ) \
				and	Is_Main__c = 'True'	\
			 order by Number_Range__c"
			 , accountId] readToEnd];
}

+(NSArray *) subProductOf:(NSString *)prodId{
	return [[[OVDatabase sharedInstance] executeQuery:
			 @"select * from Product where product_Category in (select product_Category from Product where Id = ?) and isCancel <> 'Inactive' -- and Main_Product__c <> '1' ", prodId] 
			readToEnd];
}

@end
