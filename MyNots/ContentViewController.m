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
    self.titleTextField.text = self.note.title;
    self.contentTextView.text = self.note.content;
}
- (IBAction)doneButtonClicked:(id)sender {
    [self creatNote];
}

-(void) creatNote{
    if (self.titleTextField.text.length == 0||self.contentTextView.text.length == 0){
    }else{
        self.note.title = self.titleTextField.text;
        self.note.content = self.contentTextView.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
  

//to show when you click on note on 1vc to 2vc to edit
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.titleTextField.text = self.note.title;
//    self.contentTextView.text = self.note.content;
//}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self creatNote];
}




@end
