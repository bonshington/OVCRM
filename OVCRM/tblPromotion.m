//
//  tblPromotion.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblPromotion.h"
#import "AppDelegate.h"


@implementation tblPromotion

@synthesize pK,sale_ID,promotionName,quantityType,saleMan;
@synthesize value,volumn,shopType,owner,startDate,endDate;
@synthesize promotionList = _promotionList;

//sqlite3 *database;
//sqlite3_stmt *statement;

-(NSString *)sqlName{ return @"Promotion"; }

-(NSString *)DB_Field
{
    return @" PK,Sale_ID,PromotionName,QuantityType,SaleMan,Value,Volumn,ShopType,Owner,StartDate,EndDate "; 
}

/*

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _promotionList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        const char *cPK = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }
        
        const char *cSale_ID = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempSale_ID = nil;      
        if (cSale_ID != NULL)
        {
            tempSale_ID = [NSString stringWithUTF8String: cSale_ID]; 
        }
        
        const char *cPromotionName = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempPromotionName = nil;      
        if (cPromotionName != NULL)
        {
            tempPromotionName = [NSString stringWithUTF8String: cPromotionName]; 
        }

        const char *cQuantityType = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempQuantityType = nil;      
        if (cQuantityType != NULL)
        {
            tempQuantityType = [NSString stringWithUTF8String: cQuantityType]; 
        }
        
        const char *cSaleMan = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempSaleMan = nil;      
        if (cSaleMan != NULL)
        {
            tempSaleMan = [NSString stringWithUTF8String: cSaleMan]; 
        }

        const char *cValue = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempValue = nil;      
        if (cValue != NULL)
        {
            tempValue = [NSString stringWithUTF8String: cValue]; 
        }
        
        const char *cVolumn = (const char *) sqlite3_column_text(statement, 6);
        NSString *tempVolumn = nil;      
        if (cVolumn != NULL)
        {
            tempVolumn = [NSString stringWithUTF8String: cVolumn]; 
        }
        
        const char *cShopType = (const char *) sqlite3_column_text(statement, 7);
        NSString *tempShopType = nil;      
        if (cShopType != NULL)
        {
            tempShopType = [NSString stringWithUTF8String: cShopType]; 
        }
        
        const char *cOwner = (const char *) sqlite3_column_text(statement, 8);
        NSString *tempOwner = nil;      
        if (cOwner != NULL)
        {
            tempOwner = [NSString stringWithUTF8String: cOwner]; 
        }

        const char *cStartDate = (const char *) sqlite3_column_text(statement, 9);
        NSString *tempStartDate = nil;      
        if (cStartDate != NULL)
        {
            tempStartDate = [NSString stringWithUTF8String: cStartDate]; 
        }
        
        const char *cEndDate = (const char *) sqlite3_column_text(statement, 10);
        NSString *tempEndDate = nil;      
        if (cEndDate != NULL)
        {
            tempEndDate = [NSString stringWithUTF8String: cEndDate]; 
        }
        
                
        count = count+1;
        
        tblPromotion *myPromotion = [[tblPromotion alloc]init];               
        
        myPromotion.pK = tempPK;
        myPromotion.sale_ID = tempSale_ID;
        myPromotion.promotionName = tempPromotionName;
        myPromotion.quantityType = tempQuantityType;
        myPromotion.saleMan = tempSaleMan;
        myPromotion.value = tempValue;
        myPromotion.volumn = tempVolumn;
        myPromotion.shopType = tempShopType;
        myPromotion.owner = tempOwner;
        myPromotion.startDate = tempStartDate;
        myPromotion.endDate = tempEndDate;

        [_promotionList addObject:myPromotion];
    }    
    
    sqlite3_reset(statement);
    
    return _promotionList;
}


-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr
{
    const char *cInsert = [addText UTF8String]; //"insert into Product (Product_ID,Product_Name) values (?,?)";
    NSLog(@"%@",addText);
    sqlite3_stmt *insert_statement = nil;
    
    sqlite3_prepare_v2(database, cInsert, -1, &insert_statement, NULL);
    
    
    for(int i=0;i<[paramArr count];i++)
    {
        NSLog(@"%@",[paramArr objectAtIndex:i]);
        sqlite3_bind_text(insert_statement, i+1, 
                          [[paramArr objectAtIndex:i] UTF8String],-1,SQLITE_TRANSIENT);
    }                              
    
    sqlite3_step(insert_statement);
    sqlite3_finalize(insert_statement);
    
    return YES;
}

-(bool)OpenConnection
{
    bool result = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fullPath = [path stringByAppendingPathComponent: DATABASE_NAME];
    NSLog(@"%@",fullPath);
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:fullPath];
    if (exists)
    {
        NSLog(@"%@ exist -- just opening",fullPath);
    }
    else {
        NSLog(@"%@ does not exist -- copying and opening",fullPath);       
        
        NSString *pathForStartingDB = [[NSBundle mainBundle]pathForResource:DATABASE_TITLE ofType:@"db"];
        
        //        NSLog(@"**** %@ ******",pathForStartingDB);
        
        BOOL success = [fm copyItemAtPath:pathForStartingDB toPath:fullPath error:NULL];
        if (!success)
        {
            NSLog(@"Database copy failed");
        }
    }
    
    const char *cFullPath = [fullPath cStringUsingEncoding:NSUTF8StringEncoding];
    
    if  (sqlite3_open(cFullPath, &database) != SQLITE_OK)
    {
        // NSLog(@"Unable to open database");
    }
    else {
        result = YES;
    }
    return result;
}
*/
@end
