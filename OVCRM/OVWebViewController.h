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

-(id) initForSFObject:(NSString *)url 
        withArguments:(NSDictionary *)arguments 
   withRightBarButton:(UIBarButtonItem *)button;

-(NSDictionary *)mustache;

@end



@interface OVWebViewController (UIWebViewDelegate) <UIWebViewDelegate>



@end
