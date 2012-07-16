//
//  tblPromotionLineItem.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblPromotionLineItem.h"
#import "AppDelegate.h"

@implementation tblPromotionLineItem
@synthesize promotion_PK,pK,sale_ID,product_Code,brand,product_Family;
@synthesize promotionLineItemList = _promotionLineItemList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @" promotion_PK,pK,sale_ID,product_Code,brand,product_Family "; 
}

/*
-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _promotionLineItemList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        const char *cPromotion_PK = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPromotion_PK = nil;      
        if (cPromotion_PK != NULL)
        {
            tempPromotion_PK = [NSString stringWithUTF8String: cPromotion_PK]; 
        }
        const char *cPK = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }
        const char *cSale_ID = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempSale_ID = nil;      
        if (cSale_ID != NULL)
        {
            tempSale_ID = [NSString stringWithUTF8String: cSale_ID]; 
        }
        const char *cProduct_Code = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempProduct_Code = nil;      
        if (cProduct_Code != NULL)
        {
            tempProduct_Code = [NSString stringWithUTF8String: cProduct_Code]; 
        }
        const char *cBrand = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempBrand = nil;      
        if (cBrand != NULL)
        {
            tempBrand = [NSString stringWithUTF8String: cBrand]; 
        }
        const char *cProduct_Family = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempProduct_Family = nil;      
        if (cProduct_Family != NULL)
        {
            tempProduct_Family = [NSString stringWithUTF8String: cProduct_Family]; 
        }
        //  promotion_PK,pK,sale_ID,product_Code,brand,product_Family
        count = count+1;
        
        tblPromotionLineItem *myPromotionLineItem = [[tblPromotionLineItem alloc]init];               
        
        myPromotionLineItem.pK = tempPK;
        myPromotionLineItem.promotion_PK = tempPromotion_PK;
        myPromotionLineItem.sale_ID = tempSale_ID;
        myPromotionLineItem.product_Code = tempProduct_Code;
        myPromotionLineItem.brand = tempBrand;
        myPromotionLineItem.product_Family = tempProduct_Family;
        
        [_promotionLineItemList addObject:myPromotionLineItem];
    }    
    
    sqlite3_reset(statement);
    
    return _promotionLineItemList;
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
