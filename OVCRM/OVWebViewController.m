//
//  OVWebViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/8/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVWebViewController.h"
#import "OVDatabase.h"

@implementation OVWebViewController{
    NSString        *object;
    NSDictionary    *args;
    UIBarButtonItem *rightBarButton;
}

@synthesize webView;



-(id) initForSFObject:(NSString *)url 
        withArguments:(NSDictionary *)arguments 
   withRightBarButton:(UIBarButtonItem *)button{

    self = [super initWithNibName:@"OVWebViewController" bundle:nil];
    
    if(self != nil){
        
        object = [NSString stringWithString:url];
        args = arguments;
        rightBarButton = button;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString* html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:object ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *mustache = [self mustache];
    
    for(NSString *key in [mustache allKeys]){
        
        id value = [mustache objectForKey:key];
        
        if(![value isKindOfClass:[NSString class]]){
            value = [NSString stringWithFormat:@"%@", value];
        }
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{{%@}}", key] withString:value];
    }
    
    [self.webView loadHTMLString:html baseURL:nil];
    
    if(rightBarButton != nil)
        self.navigationItem.rightBarButtonItem = rightBarButton;
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


-(NSDictionary *)mustache{
    
    NSURL *resourcePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
    
    NSMutableDictionary *mustache = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%@jquery.js", resourcePath], @"jquery.js",
                                     [NSString stringWithFormat:@"%@jquery.mobile.js", resourcePath], @"jquery.mobile.js",
                                     [NSString stringWithFormat:@"%@jquery.mobile.css", resourcePath], @"jquery.mobile.css", 
                                     [NSString stringWithFormat:@"%@site.css", resourcePath], @"site.css", 
                                     nil];
        
    OVDatabase *db = [OVDatabase sharedInstance];
    
    if(!db.open)[db open];
    
    [args enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop){
        
        if([key hasSuffix:@".Id"]){
        
            NSString *obj = [[key componentsSeparatedByString:@"."] objectAtIndex:0];
            
            FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where Id = ?", obj], [args objectForKey:key]];
            
            [result next];
            
            NSDictionary * row = result.resultDictionary;
            
            for(NSString *col in [row allKeys]){
                
                id value = [row objectForKey:col];
                
                if([value isKindOfClass:[NSString class]]){
                    [mustache setValue:[(NSString *)value htmlEncode] 
                                forKey:[NSString stringWithFormat:@"%@.%@", obj, col]];
                }
                else{
                    [mustache setValue:value 
                                forKey:[NSString stringWithFormat:@"%@.%@", obj, col]];
                }
            }
            
            [result close];
        }
    }];
    
    return mustache;
}

@end
