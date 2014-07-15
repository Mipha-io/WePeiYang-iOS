//
//  LoginViewController.h
//  Library
//
//  Created by Qin Yubo on 13-11-5.
//  Copyright (c) 2013年 Qin Yubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)login:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end
