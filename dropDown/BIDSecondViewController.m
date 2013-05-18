//
//  BIDSecondViewController.m
//  TestKim
//
//  Created by dep2 on 3/29/13.
//  Copyright (c) 2013 dep2. All rights reserved.
//

#import "BIDSecondViewController.h"
#import "BIDFirstViewController.h"

@interface BIDSecondViewController ()

@end

@implementation BIDSecondViewController
@synthesize diaryTitle;
@synthesize diaryBody;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"添加日志", @"Second");
        //self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)bgTap:(id)sender
{
    [diaryTitle resignFirstResponder];
    [diaryBody resignFirstResponder];
}

-(IBAction)saveDiary:(id)sender{

    
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"diary.plist"];
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"diary" ofType:@"plist"];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSInteger total=[dictionary count]+1;
    
    NSMutableDictionary *diaryDic=[NSMutableDictionary dictionaryWithCapacity:3];
    [diaryDic setObject:diaryTitle.text forKey:@"title"];
    [diaryDic setObject:diaryBody.text forKey:@"body"];
    NSString *dateStr= [[[NSDate date] description] substringToIndex:10];
    [diaryDic setObject:dateStr forKey:@"date"];
    
    [dictionary setObject:diaryDic forKey:[NSString stringWithFormat:@"%d",total]];
    
    //[dictionary writeToURL:plistURL atomically:NO];
    [dictionary writeToFile:plistPath atomically:YES];
    
    
    
}

@end
