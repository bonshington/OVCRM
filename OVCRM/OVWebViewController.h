//
//  OVWebViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVWebViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain, getter = getMustache, setter = setMustache:) NSDictionary *mustache;

-(id) initForSFObject:(NSString *)sObject 
         withMustache:(NSDictionary *)data 
   withRightBarButton:(UIBarButtonItem *)button;



@end



@interface OVWebViewController (UIWebViewDelegate) <UIWebViewDelegate>



@end
