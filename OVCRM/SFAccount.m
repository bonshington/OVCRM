//
//  SFAccount.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFAccount.h"
#import "AppDelegate.h"

@implementation SFAccount

#define SFAccount_init_table @"create table if not exists Account (id text primary key, Name Text, AccountNumber Text, OwnerId Text, Site Text, AnnualRevenue Text, CreatedBy Text, Description Text, NumberOfEmployees Number, Fax Text, Industry Text, LastModifiedBy Text, Ownership Text, Parent Text, Phone Text, Rating Text, Type Text, Website Text, Account_Source__c Text, Account_Number_EXT__c Text, Account_Type__c Text, Active__c Text, Addr1__c Text, Addr2__c Text, Addr3__c Text, Amphur__c Text, Average_Item__c Number, AvgSale__c Number, Balance__c Text, City__c Text, Contact_1__c Text, Contact_2__c Text, Contact_Name_1__c Text, Contact_Name_2__c Text, Contact_Name_3__c Text, Contact_Name_4__c Text, Contact_Name_5__c Text, Contact_Name_6__c Text, Contact_Position_1__c Text, Contact_Position_2__c Text, Contact_Position_3__c Text, Contact_Position_4__c Text, Contact_Position_5__c Text, Contact_Position_6__c Text, Contact_Tel_1__c Text, Contact_Tel_2__c Text, Contact_Tel_3__c Text, Contact_Tel_4__c Text, Contact_Tel_5__c Text, Contact_Tel_6__c Text, Value_2__c Text, Value_1__c Text, Customer_Priority__c Text, DiscSeq__c Text, First_Latitude__c Number, First_Longitude__c Number, Friday__c Text, GroupProm1__c Number, GroupProm2__c Number, GroupProm3__c Number, INT_ActionType__c Text, ItemProm1__c Number, ItemProm2__c Number, ItemProm3__c Number, KWS_Customer__c Text, Last_modified_time__c Text, Last_Latitude__c Number, Last_Longitude__c Number, Limit__c Number, MD_Amphur_Code__c Text, MD_City_Code__c Text, MD_Province_Code__c Text, MD_Shop_Type_Code__c Text, MD_Status_Code__c Text, MD_Customer_Business__c Text, MD_Customer_Group__c Text, Monday__c Text, No_Refund__c Text, Note_1__c Text, Note_2__c Text, Number_of_Locations__c Number, OftenNum__c Number, OftenPattern__c Text, OneTime__c Text, Order_Taking_Amount__c Number, Parent_Account_Number__c Text, Pay_Type__c Text, Phone__c Text, PriceListNo__c Text, Province__c Text, Province_Code__c Text, Route_No__c Text, Salesman__c Text, Saturday__c Text, Shop_Type__c Text, Short_Name__c Text, SLA__c Text, SLA_Expiration_Date__c Text, SLA_Serial_Number__c Text, Source_System__c Text, Status__c Text, Sunday__c Text, Term__c Number, Thursday__c Text, Tuesday__c Text, Upsell_Opportunity__c Text, Value_10__c Text, Value_3__c Text, Value_4__c Text, Value_5__c Text, Value_6__c Text, Value_7__c Text, Value_8__c Text, Value_9__c Text, VisitDayOfWeek__c Number, VisitDaySeq__c Number, VisitPattern__c Text, Wednesday__c Text)"

#define SFAccount_select @"Id,Name,AccountNumber,OwnerId,Site,AnnualRevenue,CreatedBy.Name,Description,NumberOfEmployees,Fax,Industry,LastModifiedBy.Name,toLabel(Ownership),Parent.Name,Phone,Rating,toLabel(Type),Website,Account_Source__c,Account_Number_EXT__c,Account_Type__c,Active__c,Addr1__c,Addr2__c,Addr3__c,Amphur__c,Average_Item__c,AvgSale__c,Balance__c,City__c,Contact_1__c,Contact_2__c,Contact_Name_1__c,Contact_Name_2__c,Contact_Name_3__c,Contact_Name_4__c,Contact_Name_5__c,Contact_Name_6__c,Contact_Position_1__c,Contact_Position_2__c,Contact_Position_3__c,Contact_Position_4__c,Contact_Position_5__c,Contact_Position_6__c,Contact_Tel_1__c,Contact_Tel_2__c,Contact_Tel_3__c,Contact_Tel_4__c,Contact_Tel_5__c,Contact_Tel_6__c,Value_2__c,Value_1__c,Customer_Priority__c,DiscSeq__c,First_Latitude__c,First_Longitude__c,Friday__c,GroupProm1__c,GroupProm2__c,GroupProm3__c,INT_ActionType__c,ItemProm1__c,ItemProm2__c,ItemProm3__c,KWS_Customer__c,Last_modified_time__c,Last_Latitude__c,Last_Longitude__c,Limit__c,MD_Amphur_Code__c,MD_City_Code__c,MD_Province_Code__c,MD_Shop_Type_Code__c,MD_Status_Code__c,MD_Customer_Business__c,MD_Customer_Group__c,Monday__c,No_Refund__c,Note_1__c,Note_2__c,Number_of_Locations__c,OftenNum__c,OftenPattern__c,OneTime__c,Order_Taking_Amount__c,Parent_Account_Number__c,Pay_Type__c,Phone__c,PriceListNo__c,Province__c,Province_Code__c,Route_No__c,Salesman__c,Saturday__c,Shop_Type__c,Short_Name__c,SLA__c,SLA_Expiration_Date__c,SLA_Serial_Number__c,Source_System__c,Status__c,Sunday__c,Term__c,Thursday__c,Tuesday__c,Upsell_Opportunity__c,Value_10__c,Value_3__c,Value_4__c,Value_5__c,Value_6__c,Value_7__c,Value_8__c,Value_9__c,VisitDayOfWeek__c,VisitDaySeq__c,VisitPattern__c,Wednesday__c"

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{

    OVDatabase *db = [OVDatabase sharedInstance];
    
    if(!db.open) [db open];
    
    [db executeQuery:SFAccount_init_table];
    
    NSString *cleaned = [SFAccount_select stringByReplace:[NSArray arrayWithObjects:@"toLabel", @"(", @")", @".Name", nil] withString:@""];
    
    [db insertOrReplaceTable:@"Account" 
                     columns:[cleaned componentsSeparatedByString:@","] 
                        data:[jsonResponse objectForKey:@"records"]];
    
}



+ (void) loadAccountsWithRoute:(NSString *)route{
    [super loadWithQuery:[NSString stringWithFormat:@"select %@ from Account where Route_no__c = '%@'", SFAccount_select, route] 
                delegate:[SFAccount new]];
}

@end
