//
//  ViewController.m
//  MyNots
//
//  Created by mahmoud khudairi on 3/22/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
#import "ContentViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *notes;
 @property (nonatomic, strong) Note *note;


@end

@implementation ViewController

- (void)viewDidLoad {
    self.notes =[[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self prepareTableView];
   
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    [self.tableView reloadData];
}
-(void) prepareTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma Mark TableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.notes[indexPath.row] title];
    cell.detailTextLabel.text = [self.notes[indexPath.row] content];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ self performSegueWithIdentifier:@"shownote" sender:self];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioServicesPlaySystemSound(1023);
   
    [self.notes removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   AudioServicesPlaySystemSound(1001);
    if ([segue.identifier isEqualToString:@"shownote"]) {
        
        ContentViewController *contentViewController = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
       // contentViewController.notes = self.notes
        contentViewController.note = self.notes[selectedIndexPath.row];
    } else if ([segue.identifier isEqualToString:@"addnote"]) {
        
        Note *note = [Note new];
        [self.notes addObject:note];
        ContentViewController *contentViewController = [segue destinationViewController];
        contentViewController.note = note;
    }
}
- (IBAction)editButtonClicked:(id)sender {
   
    
    [self.tableView setEditing:!self.tableView.editing];
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    

    Note *temp = [self.notes objectAtIndex:sourceIndexPath.row];
    
    [self.notes removeObjectAtIndex:sourceIndexPath.row];
    [self.notes insertObject:temp atIndex:destinationIndexPath.row];

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
@end
