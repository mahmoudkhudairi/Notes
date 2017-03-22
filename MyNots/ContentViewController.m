//
//  ContentViewController.m
//  MyNots
//
//  Created by mahmoud khudairi on 3/22/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

#import "ContentViewController.h"
#import "Note.h"
#import "ViewController.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
}
- (IBAction)doneButtonClicked:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.titleTextField.text = self.note.title;
    self.contentTextView.text = self.note.content;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.note.title = self.titleTextField.text;
    self.note.content = self.contentTextView.text;
}

@end
