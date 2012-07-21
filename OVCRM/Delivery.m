//
//  Delivery.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/25/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "Delivery.h"
#import "PCBrief.h"
#import "CellDelivery.h"
#import "ProductInAction.h"
#import "tblOrderMaster.h"
#import "tblOrderDetail.h"
#import "tblDelivery.h"
#import "tblDeliveryDetail.h"
#import "tblProduct.h"
#import "viewDatePicker.h"
#import "SalesNote.h"

@interface Delivery ()

@end

@implementation Delivery

@synthesize arrData0,arrData1,arrData2,arrData3;
@synthesize productDataDetail = _productDataDetail;
@synthesize account_ID,plan_ID,orderMaster_ID;
@synthesize cellDelivery = _cellDelivery;
@synthesize tableViewData;
@synthesize lbDeliveryAmount;
@synthesize buttonDate;
@synthesize muTableMaster,muTableDetail;
@synthesize tblorderMaster = _tblorderMaster;
@synthesize tblorderDetail = _tblorderDetail;
@synthesize tbldelivery = _tbldelivery;
@synthesize tbldeliverydetail = _tbldeliverydetail;
@synthesize tblproduct = _tblproduct;
@synthesize viewdatepicker = _viewdatepicker;
@synthesize dateSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setTitle:@"Ovaltine(TO)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToPCBrief)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    dateSelected = [[NSString alloc]init];

    _tblproduct = [[tblProduct alloc] init];
    [_tblproduct OpenConnection];
    _tblorderMaster = [[tblOrderMaster alloc]init];
    [_tblorderMaster OpenConnection];
    _tblorderDetail = [[tblOrderDetail alloc]init];
    [_tblorderDetail OpenConnection];
    _tbldelivery = [[tblDelivery alloc]init];
    [_tbldelivery OpenConnection];
    _tbldeliverydetail = [[tblDeliveryDetail alloc]init];
    [_tbldeliverydetail OpenConnection];
    muTableMaster = [[NSMutableArray alloc]init];
    muTableDetail = [[NSMutableArray alloc]init];
    
    [self deleteDelivery];
    arrData0 = [[NSArray alloc]initWithObjects:@"BPโอวัลตินUHTไฮไนน์225ML.P36(M)",@"โอวัลติน300กรัม(ถุง)(M)"
                ,@"โอวัลติน3IN1 210 กรัม",@"โอวัลติน3IN1 700G(M)",@"โอวัลติน800กรัมถุง"
                ,@"โอวัลตินUHTรสชอคไขมันต่ำ180มลP4(M)",@"โอวัลตินคลาสิค 150 กรัมถุง(M)"
                ,@"โอวัลตินชอยส์525กรัมถุง",@"โอวัลตินซอยย์สูตรผสมงาดำ490 กรัมแพ็ค14"
                ,@"โอวัลตินยูเอชทีสมาร์ท125มล.แพค4รสชอคโกแลต",@"โอวัลตินยูเอชทีไฮไนน์180มล.M"
                ,@"โอวัลตินยูเอชทีไฮไนน์225มลแพค6(M)",@"โอวัลตินเย็น3IN1ครั้นซ์ชี่630Gถุง"
                ,@"โอวัลตินเย็นครั้นซ์ชี่175กรัม ถุง(M)", nil ];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"2",@"6",@"5",@"9",@"3",@"0",@"3",@"2",@"1",@"3",@"2",@"9",@"9",@"9", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"423.00",@"55.50",@"42.50",@"118.00",@"118.00",@"43.50",@"30.00",@"98.00",@"98.00",@"32.00",@"43.50",@"71.50",@"114.00",@"38.50", nil ];
    
    arrData3 = [[NSArray alloc]initWithObjects:@"100434182",@"100498051",@"100425481",@"100425108",@"100493479",@"100457578",@"100426619",@"100438515",@"100517093",@"100591916",@"100544444",@"100573942",@"100546553",@"100540341",@"100670740",@"100673714",@"100630613",@"100613035",@"100620515",@"100659488",@"100636211",@"100674679",@"100678777",@"100691215",@"100647033",@"100660592",@"100628551", nil ];

    [self setTakeOrderPageWithPlan:plan_ID Account:account_ID];
    
    NSDate *now = [NSDate date];
    dateSelected = [[NSString alloc]initWithFormat:@"%@",[self dateToString:now]];
    
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableViewData:nil];
    [self setLbDeliveryAmount:nil];
    [self setButtonDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [buttonDate setTitle:dateSelected forState:UIControlStateNormal];
    //[buttonDate setTitle:dateSelected forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return muTableDetail.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductInAction * product = [muTableDetail objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    CellDelivery *cell = (CellDelivery *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellDelivery" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.productName.text = product.pd_Name;
    cell.productDetail.text = product.pd_ID;
    cell.fullPrice.text =  [NSString stringWithFormat:@"%i", [product.to_Quantity intValue]];
    // fullPrice ใช้เป็น จำนวนเต็ม คงเหลือ แทน
    cell.quantity.text = [ NSString stringWithFormat:@"%i", [product.to_Quantity intValue] ];
    cell.amount.text = [ NSString stringWithFormat:@"%.2f",[product.to_Total doubleValue]];
    cell.discount.text = [ NSString stringWithFormat:@"%.2f",[product.to_TotalDiscount doubleValue]];
    cell.totalAmount.text = [ NSString stringWithFormat:@"%.2f",[product.to_TotalPrice doubleValue]];
    
    [cell.quantity addTarget:self action:@selector(enterQuantityDelivery:) forControlEvents:UIControlEventEditingChanged]; 
    //    cell.order.delegate = self;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger tableWidth = tableView.frame.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,100,tableWidth,100)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * headLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,80,20)];
    headLabel0.text = @"สินค้า";
    
    UILabel * headLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/9,0,100,20)];
    headLabel1.text = @"คงเหลือ";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/9,0,100,20)];
    headLabel2.text = @"สั่งซื้อ";
    
    UILabel * headLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*6/9-50,0,100,20)];
    headLabel3.text = @"รวม";
    
    UILabel * headLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*7/9-30,0,100,20)];
    headLabel4.text = @"ส่วนลด";
    
    UILabel * headLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*8/9,0,100,20)];
    headLabel5.text = @"ยอดรวม";
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
    headLabel2.backgroundColor = [UIColor clearColor];
    headLabel3.backgroundColor = [UIColor clearColor];
    headLabel4.backgroundColor = [UIColor clearColor];
    headLabel5.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
    [headLabel2 setTextAlignment:UITextAlignmentCenter];
    [headLabel3 setTextAlignment:UITextAlignmentCenter];
    [headLabel4 setTextAlignment:UITextAlignmentCenter];
    [headLabel5 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
    [myView addSubview:headLabel1];
    [myView addSubview:headLabel2];
    [myView addSubview:headLabel3];
    [myView addSubview:headLabel4];
    [myView addSubview:headLabel5];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.view.superview addSubview:_productDataDetail.view];
}

-(void) nextToPCBrief
{
    [self SaveDelivery];
    [self calcDeliveryWait];
    if ([self isWaitForDefineDeliveryDate]) {
//        [tableViewData reloadData];
    }else {
//        PCBrief * nextView = [[PCBrief alloc]initWithNibName:@"PCBrief" bundle:nil];
//        nextView.account_ID = account_ID;
//        nextView.plan_ID = plan_ID;
//        [self.navigationController pushViewController:nextView animated:YES];
        
        SalesNote * nextView = [[SalesNote alloc]initWithNibName:@"SalesNote" bundle:nil];
        nextView.account_ID = account_ID;
        nextView.plan_ID = plan_ID;
        [self.navigationController pushViewController:nextView animated:YES];
        [nextView setPCBriefPage];
    }
    [tableViewData reloadData];
}

- (NSString *)checkInputString:(NSString *)str {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([str rangeOfCharacterFromSet:set].location != NSNotFound || str==@"") {
        //show alert view here
        str=@"0";
    }
    NSArray * tmp = [str componentsSeparatedByString:@"."];
    if (tmp.count >2) {
        str = [NSString stringWithFormat:@"%@,%@",[tmp objectAtIndex:0],[tmp objectAtIndex:1]];
    }
    str = [NSString stringWithFormat:@"%i", [str intValue] ];
    return  str;
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

-(void) setTakeOrderPageWithPlan:(NSString *)planID Account:(NSString *)accountID
{
    [muTableMaster removeAllObjects];
    [muTableDetail removeAllObjects];
    [self loadDataProduct];
}

-(void) loadDataProduct
{
    NSString *tableField = [_tblorderMaster DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from OrderMaster Where Plan_ID='%@'",tableField ,plan_ID]; 
    muTableMaster = [[NSMutableArray alloc] init];
    muTableMaster = [_tblorderMaster QueryData:searchString];

//    muTableDetail = [[NSMutableArray alloc] init];
    _tblorderMaster = [muTableMaster objectAtIndex:0];
    muTableMaster = [[NSMutableArray alloc] init];
    tableField = [_tblorderDetail DB_Field] ;
    searchString = [[NSString alloc] initWithFormat:@"select %@ , (Select Product_Name From Product P Where  P.Product_Code = Product_ID) as Product_Name ,( Select PPL.SalesPrice From ProductPrice PP Inner join ProductPriceList PPL On PP.PriceBookName = PPL.ProductPrice_PK Where PP.Account = '%@' AND Product_ID=PPL.ProductCode) as SalesPrice from OrderDetail Where OrderMaster_PK = '%@' AND Quantity>0",tableField , account_ID ,_tblorderMaster.pK];
    NSMutableArray * tempTable = [_tblorderDetail QueryDataForDeivery:searchString];
    ProductInAction * product = [[ProductInAction alloc]init];
    double sum = 0;
    for (int ii=0; ii<tempTable.count; ii++) {
        _tblorderDetail = [tempTable objectAtIndex:ii];
        product = [[ProductInAction alloc]init];
        product.to_Total = _tblorderDetail.total;
        product.to_TotalDiscount = _tblorderDetail.totalDiscount;
        product.to_Discount = _tblorderDetail.discount;
        product.to_CurrecyOrPercent = _tblorderDetail.discount_Rate;
        product.to_TotalDiscount = _tblorderDetail.totalDiscount;
        product.pd_ID = _tblorderDetail.product_ID;
        product.to_Price = _tblorderDetail.price;
        product.to_TotalPrice = _tblorderDetail.totalPrice;
        product.to_Quantity = _tblorderDetail.quantity;
        product.dl_quantity1 = _tblorderDetail.quantity;
        product.pd_Name = _tblorderDetail.product_Name;
        product.pd_Price = _tblorderDetail.price;
        product.to_SalePrice = _tblorderDetail.salesPrice;
        [self calcProductDelivery:product];
        sum = sum + [product.to_TotalPrice doubleValue];
        [muTableDetail addObject:product];
    }
    lbDeliveryAmount.text = [NSString stringWithFormat:@"%.2f",sum];
//    //    NSString * plugSqlSuggest = [NSString stringWithFormat:@" (Select Quantity / count(Quantity)  as G From Plan P Inner join OrderMaster OM On P.Plan_ID = OM.Plan_ID Inner join OrderDetail OD On OM.PK = OD.OrderMaster_PK Where P.Account_ID = '%@' AND OD.Product_ID = OrderDetail.Product_ID Group by Quantity) as Suggest ",account_ID];
//    NSString * plugSqlSuggest = [NSString stringWithFormat:@" (Select Quantity / count(Quantity)  as G From Plan P Inner join OrderMaster OM On P.Plan_ID = OM.Plan_ID Inner join OrderDetail OD On OM.PK = OD.OrderMaster_PK Where P.Account_ID = '%@' AND OD.Product_ID = OrderDetail.Product_ID Group by Quantity) as Suggest ",account_ID];
//    
//    
//    tableField = [_tblproduct DB_Field];
//    NSMutableArray * tempTable = [_tblorderDetail loadDataTakeOrderWithSuggestForAccountID:account_ID];
//    int ii = 0;
//    for (ii=0; ii<tempTable.count; ii++) {
//        ProductInAction * product = [[ProductInAction alloc]init];
//        product = [tempTable objectAtIndex:ii];
//        [self calcProductDelivery:product];
//        [muTableDetail addObject:product];
//    }
//    if (muTableMaster.count >= 1) {
//        tableField = [_tblorderDetail DB_Field];
//        tblOrderMaster * orderPK = [muTableMaster objectAtIndex:0];
//        NSString * sql = [NSString stringWithFormat:@"Select %@ , %@ , (Select Product_Name From Product P Where  P.Product_Code = Product_ID) as Product_Name From Orderdetail Where OrderMaster_PK='%@' AND Quantity>0",tableField ,plugSqlSuggest ,orderPK.pK];
//        
//        NSMutableArray * tempTable2 = [_tblorderDetail QueryData2:sql]; 
//        int jj=0;
//        for (ii=0; ii<muTableDetail.count; ii++) {
//            ProductInAction * product = [muTableDetail objectAtIndex:ii];
//            for (jj=0; jj<tempTable2.count; jj++) {
//                tblOrderDetail * order = [tempTable2 objectAtIndex:jj];
//                if ([product.pd_ID isEqualToString:order.product_ID]) {
//                    product.to_Quantity = order.quantity;
//                    product.dl_quantity1 = order.quantity;
//
//                    break;
//                }
//            }
//            [self calcProductDelivery:product];
//        }
//    }
}

-(void) enterQuantityDelivery:(UITextField *) textField{
    NSString * str = [self checkInputString:textField.text];
    NSInteger rowIndex = [self getRowIndex:textField];
    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
    product.dl_quantity1 = [NSDecimalNumber decimalNumberWithString:str];
    if ([product.to_Quantity integerValue] < [product.dl_quantity1 integerValue]) {
        product.dl_quantity1 = product.to_Quantity;
        str = [[NSString alloc]initWithFormat:@"%i",[product.dl_quantity1 intValue]];
    }
    [self calcProductDelivery:product];

    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    CellDelivery * cell = (CellDelivery *)[tableViewData cellForRowAtIndexPath:indexPath];
    cell.productName.text = product.pd_Name;
    cell.productDetail.text = product.pd_ID;
    cell.fullPrice.text =  [NSString stringWithFormat:@"%i", [product.to_Quantity intValue]];
//    [cell.quantity setText:[NSString stringWithFormat:@"%i", [product.dl_quantity1 intValue]]];
    cell.amount.text = [NSString stringWithFormat:@"%.2f",[product.to_Total doubleValue]];
    cell.discount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalDiscount doubleValue]];
    cell.totalAmount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalPrice doubleValue]];
}

-(void) calcProductDelivery:(ProductInAction *)product
{
    if ([product.to_Price doubleValue]<=0.0001) {
        product.to_SalePrice = [[NSDecimalNumber alloc]initWithString:@"0.00"];
    }
    double dbTemp = [product.dl_quantity1 doubleValue] * [product.to_SalePrice doubleValue];
    NSString * temp = [NSString stringWithFormat:@"%g",dbTemp];
    product.to_TotalPrice = [NSDecimalNumber decimalNumberWithString:temp];
    
    temp = [NSString stringWithFormat:@"%g",[product.dl_quantity1 doubleValue]* [product.to_Price doubleValue]];
    product.to_Total = [NSDecimalNumber decimalNumberWithString:temp];
    
    temp = [NSString stringWithFormat:@"%g",[product.to_Total doubleValue]- [product.to_TotalPrice doubleValue]];
    product.to_TotalDiscount = [NSDecimalNumber decimalNumberWithString:temp];
    
    int ii = 0 ;
    double sum = 0;
    for (ii=0; ii<muTableDetail.count; ii++) {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        sum = sum + [product.to_TotalPrice doubleValue];
    }
    lbDeliveryAmount.text = [NSString stringWithFormat:@"%.2f",sum];
}

-(NSString *)dateToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//@"th_TH"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

-(NSString *)timeToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

- (IBAction)buttonDateTouch:(UIButton *)sender 
{
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    _viewdatepicker.delivery = self;
    [self.view addSubview:_viewdatepicker.view];
}

-(BOOL)isWaitForDefineDeliveryDate
{
    int sumWaitGoods = 0;
    int ii=0;
    for (ii=0; ii<muTableDetail.count; ii++) 
    {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        sumWaitGoods = sumWaitGoods + [product.dl_quantity1 intValue];
    }
    if (sumWaitGoods==0) 
    {
        return NO;
    }
    return YES;
}

-(void)calcDeliveryWait
{
    for (int ii=0; ii<muTableDetail.count; ii++) {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        NSInteger qAmount = [product.to_Quantity integerValue] - [product.dl_quantity1 integerValue]; 
        product.to_Quantity = [[NSDecimalNumber alloc]initWithInt:qAmount];
        qAmount = qAmount = [product.to_Quantity integerValue];
        product.dl_quantity1 =[[NSDecimalNumber alloc]initWithInt:qAmount]; 
        [self calcProductDelivery:product];
    }
}




////////// //// // // //// ////////////////////////////////////////////////////
-(void)SaveDelivery
{
    NSString * deliveryID = [NSString stringWithFormat:@"%@",[self saveDeliveryMaster]];
    [self saveDeliveryDetail:deliveryID];
}

-(NSString *)saveDeliveryMaster
{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From Delivery Where Plan_ID = ?"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];

    dateSelected = [buttonDate.titleLabel text];
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tbldelivery GetMaxRnNo] intValue] +1];
    paramArray = [NSArray arrayWithObjects:plan_ID,newPK,dateSelected,strDate,strTime, nil];
    sql = [NSString stringWithFormat:@"Insert Into Delivery (Plan_ID,ID,Delivery_Date,DR_Date,DR_Time) Values (?,?,?,?,?)"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    return newPK;

}
-(void)saveDeliveryDetail:(NSString *)deliveryID
{
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:deliveryID, nil];
    
//    NSString * sql = [NSString stringWithFormat:@"Delete From DeliveryDetail Where OrderMaster_PK = ?"];
//    [_tblorderDetail ExecSQL:sql parameterArray:paramArray];
    
    NSString * sql ;
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tbldeliverydetail GetMaxRnNo] intValue]] ;//] +1];
    
    NSInteger ii = 0 ;
    for (ii=0; ii<muTableDetail.count; ii++) {
        newPK = [NSString stringWithFormat:@"%i",[newPK intValue]+1];
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        
        double total = [product.to_Total doubleValue];
        NSString * to_Total = [NSString stringWithFormat:@"%.2f",total];
        double TotalDiscount = [product.to_TotalDiscount doubleValue];
        NSString * to_TotalDiscount = [NSString stringWithFormat:@"%.2f",TotalDiscount];
        double Discount = [product.to_Discount doubleValue];
        NSString * to_Discount = [NSString stringWithFormat:@"%.2f",Discount];
        double RateOrVal = [product.to_RateOrVal doubleValue];
        NSString * to_RateOrVal = [NSString stringWithFormat:@"%.2f",RateOrVal];        
        double TotalPrice = [product.to_TotalPrice doubleValue];        
        NSString * to_TotalPrice = [NSString stringWithFormat:@"%.2f",TotalPrice];
        double Price = [product.to_Price doubleValue];
        NSString * to_Price = [NSString stringWithFormat:@"%.2f",Price];
        int Quantity = [product.dl_quantity1 intValue];
        NSString * dl_Quantity = [NSString stringWithFormat:@"%i",Quantity];
        
        paramArray = [NSArray arrayWithObjects:to_Total,to_TotalDiscount,deliveryID,newPK,product.pd_ID,dl_Quantity,to_Price,to_TotalPrice,to_Discount,to_RateOrVal,nil];
        //newPK,to_Total,to_TotalDiscount,to_Discount,to_RateOrVal,product.pd_ID,to_Price,to_TotalPrice,dl_Quantity,deliveryID, 
        sql = [NSString stringWithFormat:@"Insert Into DeliveryDetail ( Total, TotalDiscount, Delivery_PK, ID, Product_ID, Quantity, Price, TotalPrice, DiscountRate, Discount ) Values (?,?,?,?,?,?,?,?,?,?)"];
        if (![dl_Quantity isEqualToString:@"0"]) {
            [_tbldeliverydetail ExecSQL:sql parameterArray:paramArray];
        }
    }
}

-(void) deleteDelivery
{    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [[NSString alloc]initWithFormat:@"Select %@ From Delivery Where Plan_ID = '%@'",[_tbldelivery DB_Field],plan_ID];
    NSMutableArray * muTemp = [_tbldelivery QueryData:sql];
    if (muTemp.count > 0) {
        tblDelivery * delivery = [muTemp objectAtIndex:0];
        sql = [NSString stringWithFormat:@"Delete From Delivery Where Plan_ID = ?"];
        [_tbldelivery ExecSQL:sql parameterArray:paramArray];
        
        paramArray = [NSArray arrayWithObjects:delivery.pk, nil];
        
        sql = [NSString stringWithFormat:@"Delete From DeliveryDetail Where Delivery_PK = ?"];
        [_tbldeliverydetail ExecSQL:sql parameterArray:paramArray];
    }
}


@end
