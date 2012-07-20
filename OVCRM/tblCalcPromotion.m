//
//  tblCalcPromotion.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblCalcPromotion.h"
#import "AppDelegate.h"

@implementation tblCalcPromotion

@synthesize pk, promotionName, itemOrder, orderAmount, orderQuantity, quantity, amount;
@synthesize free, itemPromotion;
@synthesize tblcalcPromotion = _tblcalcPromotion;


sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)sqlName{ return @"Promotion"; }

-(NSString *)DB_Field
{
    return @" ID, PromotionName, ItemOrder, Quantity, Amount, ItemPromotion "; 
}

-(NSMutableArray *)QueryPromotionWithProductCodeIn:(NSString *) productCodeString
{  
    NSString * sqlText = [NSString stringWithFormat:@"Select P.PK, P.PromotionName "
                          " ,PC.Product_Code as ItemOrder, "
                          " PC.Quantity, PC.Amount, PL.Product_Code as ItemPromotion "
                          " From Promotion P "
                          " Inner join PromotionCriteria PC On P.PK = PC.Promotion_PK "
                          " Inner join PromotionLineItem PL On P.PK = PC.Promotion_PK "
                          " Where PC.Product_Code in (%@) ",productCodeString];
    NSLog(@"%@",sqlText);
    _tblcalcPromotion = [[NSMutableArray alloc]init];
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
        const char *cPromotionName = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempPromotionName = nil;      
        if (cPromotionName != NULL)
        {
            tempPromotionName = [NSString stringWithUTF8String: cPromotionName]; 
        }
        const char *cItemOrder = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempItemOrder = nil;      
        if (cItemOrder != NULL)
        {
            tempItemOrder = [NSString stringWithUTF8String: cItemOrder]; 
        }
        int tempQuantity = sqlite3_column_int(statement, 3);
        
        double tempAmount = sqlite3_column_double(statement, 4);
        
        const char *cItemPromotion = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempItemPromotion = nil;      
        if (cItemPromotion != NULL)
        {
            tempItemPromotion = [NSString stringWithUTF8String: cItemPromotion]; 
        }
        
//      PK, PromotionName, ItemOrder, Quantity, Amount, ItemPromotion
        count = count+1;
        
        tblCalcPromotion *myCalcPromotion = [[tblCalcPromotion alloc]init];               
        myCalcPromotion.pk = tempPK;
        myCalcPromotion.promotionName = tempPromotionName;
        myCalcPromotion.itemOrder = tempItemOrder;
        myCalcPromotion.quantity = [[NSDecimalNumber alloc]initWithInt:tempQuantity];
        myCalcPromotion.amount = [[NSDecimalNumber alloc]initWithDouble:tempAmount];
        myCalcPromotion.itemPromotion = tempItemPromotion;
        
        [_tblcalcPromotion addObject:myCalcPromotion];
    }    
    
    sqlite3_reset(statement);
    
    return _tblcalcPromotion;
}
/*
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
