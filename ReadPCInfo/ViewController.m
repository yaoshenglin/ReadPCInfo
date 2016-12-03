//
//  ViewController.m
//  ReadPCInfo
//
//  Created by xy on 16/9/21.
//  Copyright © 2016年 xy. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSTextView *textView = _txtContent.documentView;
    textView.editable = NO;
}

- (IBAction)readPCInfo:(NSButton *)sender
{
    NSArray *listTitle = @[@"CPU型号：",@"CPU核心数：",@"CPU线程数：",@"其它信息："];
    NSArray *list = @[@"sysctl -n machdep.cpu.brand_string",@"sysctl -n machdep.cpu.core_count",@"sysctl -n machdep.cpu.thread_count",@"system_profiler SPDisplaysDataType SPMemoryDataType SPStorageDataType"];
    
    NSString *content = @"";
    for (int i=0; i<list.count; i++) {
        NSString *script = list[i];
        NSString *title = listTitle[i];
        NSString *stringValue = [self executeShellWithScript:script];
        content = [content stringByAppendingFormat:@"%@%@\n",title,stringValue];
    }
    
    
    NSTextView *textView = _txtContent.documentView;
    textView.string = content;
}

- (NSString *)executeShellWithScript:(NSString *)script
{
    NSDictionary *errorInfo = [NSDictionary dictionary];
    script = [NSString stringWithFormat:@"do shell script \"%@\"",script];
    NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script];
    NSAppleEventDescriptor *des = [appleScript executeAndReturnError:&errorInfo];
    NSString *stringValue = des.stringValue;
    return stringValue;
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
