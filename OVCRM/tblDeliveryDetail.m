//
//  tblDeliveryDetail.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblDeliveryDetail.h"
#import "AppDelegate.h"

@implementation tblDeliveryDetail

@synthesize total,totalDiscount;
@synthesize delivery_PK,pk,Product_ID;
@synthesize quantity,price,totalPrice;
@synthesize discount,discountRate;
@synthesize deliveryDetailList = _deliveryDetailList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @" Total, TotalDiscount, Delivery_PK, PK, Product_ID, Quantity, Price, TotalPrice, DiscountRate, Discount "; 
}
/*
-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _deliveryDetailList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        double tempTotal =  sqlite3_column_double(statement, 0);
        double tempTotalDiscount =  sqlite3_column_double(statement, 1);
        const char *cDelivery_PK = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempDelivery_PK = nil;      
        if (cDelivery_PK != NULL)
        {
            tempDelivery_PK = [NSString stringWithUTF8String: cDelivery_PK]; 
        }
        const char *cPK = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }
        const char *cProduct_ID = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempProduct_ID = nil;      
        if (cProduct_ID != NULL)
        {
            tempProduct_ID = [NSString stringWithUTF8String: cProduct_ID]; 
        }
        int tempQuantity =  sqlite3_column_int(statement, 5);
        double tempPrice =  sqlite3_column_double(statement, 6);
        double tempTotalPrice =  sqlite3_column_double(statement, 7);
        double tempDiscountRate =  sqlite3_column_double(statement, 8);
        double tempDiscount =  sqlite3_column_double(statement, 9);
        count = count+1;
        
        tblDeliveryDetail *mydeliveryDetail = [[tblDeliveryDetail alloc]init];               
        
        mydeliveryDetail.total = [[NSDecimalNumber alloc]initWithDouble:tempTotal];
        mydeliveryDetail.totalDiscount = [[NSDecimalNumber alloc]initWithDouble:tempTotalDiscount];
        mydeliveryDetail.delivery_PK = tempDelivery_PK;
        mydeliveryDetail.pk = tempPK;
        mydeliveryDetail.Product_ID = tempProduct_ID;
        mydeliveryDetail.quantity = [[NSDecimalNumber alloc]initWithInt:tempQuantity];
        mydeliveryDetail.price = [[NSDecimalNumber alloc]initWithDouble:tempPrice];
        mydeliveryDetail.totalPrice = [[NSDecimalNumber alloc]initWithDouble:tempTotalPrice];
        mydeliveryDetail.discountRate = [[NSDecimalNumber alloc]initWithDouble:tempDiscountRate];
        mydeliveryDetail.discount = [[NSDecimalNumber alloc]initWithDouble:tempDiscount];
        
        [_deliveryDetailList addObject:mydeliveryDetail];
    }    
    
    sqlite3_reset(statement);
    
    return _deliveryDetailList;
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

-(NSString *)GetMaxRnNo
{
    
    NSString * tempMax = nil;  
    NSString * sql = [NSString stringWithFormat:@"Select PK From DeliveryDetail Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From DeliveryDetail)"];
    
    const char *cQuery = [sql UTF8String]; 
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    NSInteger *count=0;
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        const char *PK = (const char *) sqlite3_column_text(statement, 0);
        if (PK != NULL) 
        {
            tempMax = [NSString stringWithUTF8String: PK]; 
        }  
        count = count+1;
    }
    return tempMax;
}
*/
@end
