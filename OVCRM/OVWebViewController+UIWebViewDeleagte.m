//
//  OVWebViewController+UIWebViewDeleagte.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVWebViewController.h"

@implementation OVWebViewController (UIWebViewDeleagte)

- (BOOL)            webView:(UIWebView *)webView 
 shouldStartLoadWithRequest:(NSURLRequest *)request 
             navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *queryString = request.URL.query;
    int a = 5;
    
    return YES;
}


/*
 @optional
 - (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request 
  navigationType:(UIWebViewNavigationType)navigationType;
 
 - (void)webViewDidStartLoad:(UIWebView *)webView;
 
 - (void)webViewDidFinishLoad:(UIWebView *)webView;
 
 - (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error; 
 
 */

@end
