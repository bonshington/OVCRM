//
//  tblPromotionCriteria.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblPromotionCriteria.h"
#import "AppDelegate.h"

@implementation tblPromotionCriteria

@synthesize promotion_PK,pk,sale_ID,quantity,amount,product_Code;
@synthesize promotionCriteriaList = _promotionCriteriaList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @" Promotion_PK,PK,Sale_ID,Quantity,Amount,Product_Code "; 
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _promotionCriteriaList = [[NSMutableArray alloc]init];
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
        
        const char *cPK = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }
        
        const char *cSale_ID = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempSale_ID = nil;      
        if (cSale_ID != NULL)
        {
            tempSale_ID = [NSString stringWithUTF8String: cSale_ID]; 
        }
        
        int tempQuantity = sqlite3_column_int(statement, 3);
        
        double tempAmount = sqlite3_column_double(statement, 4);
        
        const char *cProduct_Code = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempProduct_Code = nil;      
        if (cProduct_Code != NULL)
        {
            tempProduct_Code = [NSString stringWithUTF8String: cProduct_Code]; 
        }
                
//      Promotion_PK,PK,Sale_ID,Quantity,Amount,Product_Code 
        count = count+1;
        
        tblPromotionCriteria *myCriteria = [[tblPromotionCriteria alloc]init];               
        
        myCriteria.pk = tempPK;
        myCriteria.promotion_PK = tempPromotion_PK;
        myCriteria.sale_ID = tempSale_ID;
        myCriteria.quantity = [[NSDecimalNumber alloc]initWithInt:tempQuantity];
        myCriteria.amount = [[NSDecimalNumber alloc]initWithDouble:tempAmount];
        myCriteria.product_Code = tempProduct_Code;
        
        [_promotionCriteriaList addObject:myCriteria];
    }    
    
    sqlite3_reset(statement);
    
    return _promotionCriteriaList;
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

@end
