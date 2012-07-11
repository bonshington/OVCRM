//
//  OVWebViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVWebViewController.h"
#import "OVDatabase.h"
#import "FMResultSet+Extension.h"
#import "NSArray+Extension.h"

@implementation OVWebViewController{
    NSString        *_sObject;
    NSDictionary    *_mustache;
    UIBarButtonItem *_rightBarButton;
}

@synthesize webView, mustache;



-(id) initForSFObject:(NSString *)sObject 
        withMustache:(NSDictionary *)data 
   withRightBarButton:(UIBarButtonItem *)button{

    self = [super initWithNibName:@"OVWebViewController" bundle:nil];
    
    if(self != nil){
        
        _sObject = [NSString stringWithString:sObject];
        self.mustache = data;
        _rightBarButton = button;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString* html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_sObject ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    for(NSString *key in [self.mustache allKeys]){
        
        id value = [self.mustache objectForKey:key];
        
        if(![value isKindOfClass:[NSString class]]){
            value = [NSString stringWithFormat:@"%@", value];
        }
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{{%@}}", key] withString:value];
    }
    
    [self.webView loadHTMLString:html baseURL:nil];
    
    if(_rightBarButton != nil)
        self.navigationItem.rightBarButtonItem = _rightBarButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark - accessor

-(NSDictionary *)getMustache{
    return _mustache;
}

-(void)setMustache:(NSDictionary *)value{
    
    if(value == nil)
        _mustache = nil;
    
    NSURL *resourcePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
    
    
    _mustache = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                 [NSString stringWithFormat:@"%@jquery.js", resourcePath], @"jquery.js",
                 [NSString stringWithFormat:@"%@jquery.mobile.js", resourcePath], @"jquery.mobile.js",
                 [NSString stringWithFormat:@"%@jquery.mobile.css", resourcePath], @"jquery.mobile.css", 
                 [NSString stringWithFormat:@"%@plugin.js", resourcePath], @"plugin.js",
                 [NSString stringWithFormat:@"%@site.css", resourcePath], @"site.css", 
                 nil];
    
    
    [value enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *entries, BOOL *stopLoop){
        
        if(entries.count > 0){
            
            [[entries objectAtIndex:0] enumerateKeysAndObjectsUsingBlock:^(NSString *col, id val, BOOL *stopFindColumn){
                [_mustache setValue:val forKey:[NSString stringWithFormat:@"%@.%@", key, col]];
            }];
            
            [_mustache setValue:[entries toJson] forKey:[NSString stringWithFormat:@"%@.json", key]];
        }
    }];
    
}

@end
