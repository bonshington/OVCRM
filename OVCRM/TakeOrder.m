//
//  TakeOrder.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "TakeOrder.h"
#import "tblOrderMaster.h"
#import "tblOrderDetail.h"
#import "Delivery.h"
#import "ProductInAction.h"
#import "tblProduct.h"
#import "tblCalcPromotion.h"
#import "cellTakeOrder.h"

@interface TakeOrder ()

@end

@implementation TakeOrder
@synthesize checkedPromotion;
@synthesize btnTest;
@synthesize account_ID,plan_ID;
@synthesize arrData0,arrData1,arrData2,arrData3;

@synthesize muTableMaster,muTableDetail,muTableTempDetail;
@synthesize tblorderDetail = _tblorderDetail;
@synthesize tblorderMaster = _tblorderMaster;
@synthesize tblproduct = _tblproduct;
@synthesize tblcalcPromotion = _tblcalcPromotion;
@synthesize searchProduct = _searchProduct;
@synthesize lbOrderTotal;
@synthesize productDataDetail = _productDataDetail;
@synthesize celltakeOrder = _celltakeOrder;
@synthesize tableViewData;

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
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToDelivery)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
//    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    checkedPromotion = NO;
    _tblproduct = [[tblProduct alloc] init];
    [_tblproduct OpenConnection];
    _tblorderMaster = [[tblOrderMaster alloc]init];
    [_tblorderMaster OpenConnection];
    _tblorderDetail = [[tblOrderDetail alloc]init];
    [_tblorderDetail OpenConnection];
    _tblcalcPromotion = [[tblCalcPromotion alloc]init];
    [_tblcalcPromotion OpenConnection];
    muTableMaster = [[NSMutableArray alloc]init];
    muTableDetail = [[NSMutableArray alloc]init];
    muTableTempDetail = [[NSMutableArray alloc]init];
    
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
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBtnTest:nil];
    [self setTableViewData:nil];
    [self setLbOrderTotal:nil];
    //[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [tableViewData reloadData];
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
    
    cellTakeOrder *cell = (cellTakeOrder *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cellTakeOrder" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.productName.text = product.pd_Name;
    cell.productDetail.text = product.pd_ID;
    cell.Suggest.text =  [ NSString stringWithFormat:@"%i", [product.to_Suggest intValue] ];
    cell.order.text = [ NSString stringWithFormat:@"%i", [product.to_Quantity intValue] ];
    cell.total.text = [ NSString stringWithFormat:@"%.2f",[product.to_Total doubleValue]];
    cell.discount.text = [ NSString stringWithFormat:@"%.2f",[product.to_TotalDiscount doubleValue]];
    cell.totalAmount.text = [ NSString stringWithFormat:@"%.2f",[product.to_TotalPrice doubleValue]];
    
    [cell.order addTarget:self action:@selector(enterQuantity:) forControlEvents:UIControlEventEditingChanged]; 
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
    headLabel1.text = @"แนะนำ";
    
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
    NSArray * array = [NSArray arrayWithObjects:indexPath, nil];
    [tableViewData reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
}


-(void) touchInfo:(UIButton *)btnInfo
{
    [self lookProductInfo];
}

-(void) changeQuantityTextField:(UITextField *) txtField AtRow:(NSInteger) rowIndex {
    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
    [product setTo_Quantity:[[NSDecimalNumber alloc]initWithString:txtField.text]]; 
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

/////////////////////////////////////////////////////////////////////



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
    NSString * plugSqlSuggest = [NSString stringWithFormat:@" (Select Quantity / count(Quantity)  as G From Plan P Inner join OrderMaster OM On P.Plan_ID = OM.Plan_ID Inner join OrderDetail OD On OM.ID = OD.OrderMaster_PK Where P.Account_ID = '%@' AND P.Plan_ID<>'%@' AND OD.Product_ID = OrderDetail.Product_ID Group by Quantity) as Suggest ",account_ID,plan_ID];
    

    tableField = [_tblproduct DB_Field];
    NSMutableArray * tempTable = [_tblorderDetail loadDataTakeOrderWithSuggestForAccountID:account_ID];
    int ii = 0;
    for (ii=0; ii<tempTable.count; ii++) {
        ProductInAction * product = [[ProductInAction alloc]init];
        product = [tempTable objectAtIndex:ii];
        [self calcProductTakeOrder:product];
        [muTableDetail addObject:product];
    }
    if (muTableMaster.count >= 1) {
        tableField = [_tblorderDetail DB_Field];
        tblOrderMaster * orderPK = [muTableMaster objectAtIndex:0];
        NSString * sql = [NSString stringWithFormat:@"Select %@ , %@ , (Select Product_Name From Product P Where  P.Product_Code = Product_ID) as Product_Name From Orderdetail Where OrderMaster_PK='%@' AND Price > 0.0001",tableField ,plugSqlSuggest ,orderPK.pK];

        NSMutableArray * tempTable2 = [_tblorderDetail QueryData2:sql]; 
        int jj=0;
        for (ii=0; ii<muTableDetail.count; ii++) {
            ProductInAction * product = [muTableDetail objectAtIndex:ii];
            for (jj=0; jj<tempTable2.count; jj++) {
                tblOrderDetail * order = [tempTable2 objectAtIndex:jj];
                if ([product.pd_ID isEqualToString:order.product_ID]) {
                    product.to_Quantity = order.quantity;
                    break;
                }
            }
            [self calcProductTakeOrder:product];
        }
    }
    
    double sum = 0;
    for (ii=0; ii<muTableDetail.count; ii++) {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        sum = sum + [product.to_TotalPrice doubleValue];
    }
    lbOrderTotal.text = [NSString stringWithFormat:@"%.2f",sum];
}

-(NSDecimalNumber *) calcSuggestOfProductID:(NSString *) product_ID{
    return 0;
}

/////////////////////////////////////////////////////////////////////
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

- (UITextField *)checkTextField:(UITextField *)textField {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound || textField.text==@"") {
        //show alert view here
        textField.text=@"0";
    }
    NSArray * tmp = [textField.text componentsSeparatedByString:@"."];
    if (tmp.count >2) {
        textField.text = [NSString stringWithFormat:@"%@,%@",[tmp objectAtIndex:0],[tmp objectAtIndex:1]];
    }
    textField.text = [NSString stringWithFormat:@"%i", [textField.text intValue]];
    return textField;
}

-(void) nextToDelivery
{
    [self calculatePromotion];
    [tableViewData reloadData];
    NSString * orderID = [self SaveTakeOrder];
    Delivery * nextView = [[Delivery alloc]initWithNibName:@"Delivery" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    nextView.orderMaster_ID = orderID;
    [self.navigationController pushViewController:nextView animated:YES];
}

-(NSString *) SaveTakeOrder
{
    NSString * orderID = [NSString stringWithFormat:@"%@",[self SaveOrderMaster]];
    [self SaveOrderDetailWithPK:orderID];
    return orderID;
}

-(NSString *) SaveOrderMaster
{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From OrderMaster Where Plan_ID = ?"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblorderMaster GetMaxRnNo] intValue] +1];
    paramArray = [NSArray arrayWithObjects:plan_ID,newPK,strDate,strTime,lbOrderTotal.text, nil];
    sql = [NSString stringWithFormat:@"Insert Into OrderMaster (Plan_ID,ID,Order_Date,Order_Time,Order_Total) Values (?,?,?,?,?)"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    return newPK;
}

-(void) SaveOrderDetailWithPK:(NSString *)orderMasterPK
{
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:orderMasterPK, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From OrderDetail Where OrderMaster_PK = ?"];
    [_tblorderDetail ExecSQL:sql parameterArray:paramArray];
    
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblorderDetail GetMaxRnNo] intValue]] ;//] +1];
    
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
        double Quantity = [product.to_Quantity doubleValue];
        NSString * to_Quantity = [NSString stringWithFormat:@"%.2f",Quantity];
        
        paramArray = [NSArray arrayWithObjects:newPK,to_Total,to_TotalDiscount,to_Discount,to_RateOrVal,product.pd_ID,to_Price,to_TotalPrice,to_Quantity,orderMasterPK, nil];
        sql = [NSString stringWithFormat:@"Insert Into OrderDetail (ID ,Total ,TotalDiscount ,Discount ,DiscountRate ,Product_ID ,Price ,TotalPrice , Quantity ,OrderMaster_PK ) Values (?,?,?,?,?,?,?,?,?,?)"];
        [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    }
}

-(void) lookProductInfo
{
    //    [self SaveMerchandise];
    ProductDataDetail * nextView = [[ProductDataDetail alloc]initWithNibName:@"ProductDataDetail" bundle:nil];
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void) calcProductTakeOrder:(ProductInAction *)product
{
    NSString * temp = [NSString stringWithFormat:@"%g",[product.to_Quantity doubleValue]* [product.to_SalePrice doubleValue]];
    product.to_TotalPrice = [NSDecimalNumber decimalNumberWithString:temp];
    
    temp = [NSString stringWithFormat:@"%g",[product.to_Quantity doubleValue]* [product.to_Price doubleValue]];
    product.to_Total = [NSDecimalNumber decimalNumberWithString:temp];
    
    temp = [NSString stringWithFormat:@"%g",[product.to_Total doubleValue]- [product.to_TotalPrice doubleValue]];
    product.to_TotalDiscount = [NSDecimalNumber decimalNumberWithString:temp];
    
    int ii = 0 ;
    double sum = 0;
    for (ii=0; ii<muTableDetail.count; ii++) {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        sum = sum + [product.to_TotalPrice doubleValue];
    }
    lbOrderTotal.text = [NSString stringWithFormat:@"%.2f",sum];
}

- (NSString *)checkIntegerTextField:(NSString *)str {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if ([str rangeOfCharacterFromSet:set].location != NSNotFound || [str isEqualToString:@""]) {
        str=@"0";
    }
    str = [NSString stringWithFormat:@"%i",[str integerValue]];
    return str;
}

- (NSString *)checkDecimalTextField:(NSString *)str {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([str rangeOfCharacterFromSet:set].location != NSNotFound || [str isEqualToString:@""]) {
        str=@"0";
    }
    NSArray * tmp = [str componentsSeparatedByString:@"."];
    if (tmp.count >2) {
        str = [NSString stringWithFormat:@"%@,%@",[tmp objectAtIndex:0],[tmp objectAtIndex:1]];
    }
    str = [NSString stringWithFormat:@"%.2f",[str doubleValue]];
    return str;
}

- (BOOL)              textField:(UITextField *)textField
  shouldChangeCharactersInRange:(NSRange)range     
              replacementString:(NSString *)string{
    
    string = [[NSString alloc]initWithFormat:@"%@%@",textField.text,string];
    NSString * str = [self checkInputString:string];
    NSInteger rowIndex = [self getRowIndex:textField];
    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
    product.to_Quantity = [NSDecimalNumber decimalNumberWithString:str];
    [self calcProductTakeOrder:product];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    cellTakeOrder * cell = (cellTakeOrder *)[tableViewData cellForRowAtIndexPath:indexPath];
    cell.productName.text = product.pd_Name;
    cell.productDetail.text = product.pd_ID;
    cell.Suggest.text =  [NSString stringWithFormat:@"%i", [product.to_Suggest intValue]];
//    [cell.order setText:[NSString stringWithFormat:@"%i", [product.to_Quantity intValue]]];
    cell.total.text = [NSString stringWithFormat:@"%.2f",[product.to_Total doubleValue]];
    cell.discount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalDiscount doubleValue]];
    cell.totalAmount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalPrice doubleValue]];
//    cell.order.delegate = self;
    return YES;
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


- (IBAction)testButton:(UIButton *)sender {

    if (checkedPromotion == NO) {
        [self calculatePromotion];
    }else {
        checkedPromotion = NO;
        [btnTest setTitle:@"Promotion" forState:UIControlStateNormal];
         //.titleLabel setText:@"DisPromotion"];
        [self removeItemFree];
        [tableViewData setAlpha:1.0];
        [tableViewData setUserInteractionEnabled:YES];
    }
    [tableViewData reloadData];
}

-(void)calcPromotion{
    int ii = 0 ;
//    NSMutableArray * arrayOrderItem = [[NSMutableArray alloc]init];
    NSString * strOrderItem = [[NSString alloc]init];
    NSMutableArray * arrayPromotion = [[NSMutableArray alloc]init];
    for (ii=muTableDetail.count-1; ii>=0; ii--) {
        ProductInAction *product = [muTableDetail objectAtIndex:ii];
        if ([product.to_Quantity intValue] < 1) {
//            [muTableDetail removeObjectAtIndex:ii];
        }else {
            if ([strOrderItem length]<1) {
                strOrderItem = [NSString stringWithFormat:@"%@ '%@'",strOrderItem, product.pd_ID];
            }else {
                strOrderItem = [NSString stringWithFormat:@"%@ ,'%@'",strOrderItem, product.pd_ID];
            }
        }
    }
    
    arrayPromotion = [_tblcalcPromotion QueryPromotionWithProductCodeIn:strOrderItem];
    for (ii=0; ii<arrayPromotion.count; ii++) {
        [self matchItemPromotion:[arrayPromotion objectAtIndex:ii]];
    }
    
    int jj=0;
    for (ii=0; ii<arrayPromotion.count; ii++) {
        for (jj=0; jj<muTableDetail.count; jj++) {
            tblCalcPromotion * promotion = [arrayPromotion objectAtIndex:ii];
            ProductInAction * product = [muTableDetail objectAtIndex:jj];
            if ([product.pd_ID isEqualToString:promotion.itemPromotion]&&[promotion.free intValue]>=1) {
                int qty = [promotion.free intValue];
                ProductInAction * freeProduct = [[ProductInAction alloc]init];
                
                freeProduct.pd_ID = product.pd_ID;
                freeProduct.pd_Name = product.pd_Name;
                freeProduct.pd_Price = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_Quantity = [[NSDecimalNumber alloc]initWithInt:qty];
                freeProduct.to_Discount = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_Price = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_SalePrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_Suggest = [NSDecimalNumber decimalNumberWithString:@"0"];;
                freeProduct.to_Total = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_TotalDiscount = [NSDecimalNumber decimalNumberWithString:@"0"];
                freeProduct.to_TotalPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                [muTableDetail addObject:freeProduct];
                break;
            }
        }
    }
}

-(void)matchItemPromotion:(tblCalcPromotion *) promotion{
    [tableViewData reloadData];
    int ii = 0 ;
    for (ii=0; ii<muTableDetail.count; ii++) {
        ProductInAction *product = [muTableDetail objectAtIndex:ii];
        if ([product.pd_ID isEqualToString:promotion.itemOrder]) {
            promotion.orderQuantity = product.to_Quantity; 
            promotion.orderAmount = product.to_Total;
            double free = 0;
            if ([promotion.quantity intValue]>0.0001) {
                free += [promotion.orderQuantity intValue]/[promotion.quantity intValue];
            }else if ([promotion.amount doubleValue]>0.0001) {
                free += ([promotion.orderAmount doubleValue]/[promotion.amount doubleValue]);
            }
            promotion.free = [[NSDecimalNumber alloc]initWithInt:(int)free];
            break;
        }
    }
}

-(void)removeItemFree{
    int ii = 0;
    for (ii=muTableDetail.count-1; ii>=0; ii--) {
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        if ([product.to_Price intValue]==0) {
            [muTableDetail removeObjectAtIndex:ii];
        }
    }
}

-(void) calculatePromotion{
    if (checkedPromotion == NO) {
        [self setCheckedPromotion:YES];
        [btnTest setTitle:@"Take Order" forState:UIControlStateNormal];
        //.titleLabel setText:@"Promotion"];
        [tableViewData setAlpha:0.7];
        [self calcPromotion];
        [tableViewData setUserInteractionEnabled:NO];
    }
}


-(void) enterQuantity:(UITextField *) textField{
    NSString * str = [self checkInputString:textField.text];
    NSInteger rowIndex = [self getRowIndex:textField];
    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
    product.to_Quantity = [NSDecimalNumber decimalNumberWithString:str];
    [self calcProductTakeOrder:product];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    cellTakeOrder * cell = (cellTakeOrder *)[tableViewData cellForRowAtIndexPath:indexPath];
    cell.productName.text = product.pd_Name;
    cell.productDetail.text = product.pd_ID;
    cell.Suggest.text =  [NSString stringWithFormat:@"%i", [product.to_Suggest intValue]];
//    [cell.order setText:[NSString stringWithFormat:@"%i", [product.to_Quantity intValue]]];
    cell.total.text = [NSString stringWithFormat:@"%.2f",[product.to_Total doubleValue]];
    cell.discount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalDiscount doubleValue]];
    cell.totalAmount.text = [NSString stringWithFormat:@"%.2f",[product.to_TotalPrice doubleValue]];
    //    cell.order.delegate = self;
   
}

@end
