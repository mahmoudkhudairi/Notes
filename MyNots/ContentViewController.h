//
//  ContentViewController.h
//  MyNots
//
//  Created by mahmoud khudairi on 3/22/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface ContentViewController : UIViewController
@property (nonatomic, strong) Note *note;
@property (nonatomic, strong) NSMutableArray *notes;
@end
