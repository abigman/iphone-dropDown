//
//  BIDSecondViewController.h
//  TestKim
//
//  Created by dep2 on 3/29/13.
//  Copyright (c) 2013 dep2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDSecondViewController : UIViewController
@property (strong,nonatomic) IBOutlet UITextField *diaryTitle;
@property (strong,nonatomic) IBOutlet UITextView *diaryBody;

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)bgTap:(id)sender;
-(IBAction)saveDiary:(id)sender;
@end
