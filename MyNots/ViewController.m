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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSMutableArray *notes;



@end

@implementation ViewController

- (void)viewDidLoad {
    self.notes =[[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self prepareTableView];
    [self prepareSound];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
-(void) prepareSound{
    // Construct URL to sound file
    NSString *path1 = [NSString stringWithFormat:@"%@/delete.mp3", [[NSBundle mainBundle] resourcePath]];
    NSString *path2 = [NSString stringWithFormat:@"%@/segue.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *deleteUrl = [NSURL fileURLWithPath:path1];
    NSURL *segueUrl = [NSURL fileURLWithPath:path2];
    // Audio player object and initialize with URL to sound
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:deleteUrl error:nil];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:segueUrl error:nil];
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
    
   [audioPlayer1 play];
    [self.notes removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"shownote"]) {
         [audioPlayer2 play];
        ContentViewController *contentViewController = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        contentViewController.note = self.notes[selectedIndexPath.row];
    } else if ([segue.identifier isEqualToString:@"addnote"]) {
         [audioPlayer2 play];
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
