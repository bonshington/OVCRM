//
//  InvoiceList.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceDetail.h"

@class tblInvoice;
@class tblCollection;
@class tblParameter;

@interface InvoiceList : UIViewController
<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
	
	UILabel *lbTotalAmount;
	UILabel *lbPayTotal;
}

@property (nonatomic, strong) NSString * account_ID;
@property (nonatomic, strong) NSString * plan_ID;
@property (nonatomic, strong) NSMutableArray * muTableData;
@property (nonatomic, strong) NSMutableArray * arrCollectionData;
@property (nonatomic, strong) NSMutableArray * arrSelectInvoice;
@property (nonatomic, strong) NSString *selectInvoice;
@property (nonatomic, strong) tblInvoice * tblinvoice;
@property (nonatomic, strong) tblCollection * tblcollection;
@property (nonatomic, strong) tblParameter * tblParameter;
//@property (strong, nonatomic) IBOutlet UILabel *lbTotalAmount;
//@property (strong, nonatomic) IBOutlet UILabel *lbPayTotal;
@property (strong, nonatomic) IBOutlet UITableView * tableData;
@property (strong, nonatomic) IBOutlet InvoiceDetail * invoiceDetail;

@property (strong, nonatomic) NSString * payType;
// ปุ่ม Pay / Cancel และข้อมูลการชำระเงินด้านล่าง

@property (strong, nonatomic) IBOutlet UIButton *btnPayInvoice;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelAmount;
@property (strong, nonatomic) IBOutlet UILabel *part2lbMoney;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBaht;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelReceive;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtReceive;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBahtRcv;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelCheck;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtCheckNo;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelTransfNo;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtTransfNo;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBank;
@property (strong, nonatomic) IBOutlet UIButton *part2BtnBank;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBranch;
@property (strong, nonatomic) IBOutlet UIButton *part2BtnBranch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *part2SegmentPay;
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;

@property (strong, nonatomic) NSMutableArray *arrSearchBank;
@property (strong, nonatomic) NSMutableArray *arrSearchBranch;
@property (strong, nonatomic) NSMutableArray *parameterList;
@property (strong, nonatomic)NSMutableArray *arrPickerList;
@property (strong, nonatomic) NSString *pickerType;
@property (strong, nonatomic) NSString *bankValue;
@property (strong, nonatomic) NSString *branchValue;
@property (strong, nonatomic) NSMutableDictionary *dicBank;



/* sue */
@property (nonatomic, retain) IBOutlet UIView *paymentView;
/*******/

- (IBAction)touchPayInvoice:(id)sender;
- (IBAction)enterReceive:(UITextField *)sender;

- (IBAction)backgroungTab;
- (IBAction)ShowBankPicker;
- (IBAction)ShowBranchPicker;

- (IBAction)segmentChanged:(UISegmentedControl *)sender;

-(void) CalTotalInvoice:(NSString *)invoiceAmt rowIndexSelect:(NSInteger) rowIndex;


@end


@interface InvoiceList (UITableViewHandler)<UITableViewDataSource,UITableViewDelegate>

@end
