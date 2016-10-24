//
//  ViewController.m
//  MyReader
//
//  Created by mac on 10/18/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "ViewController.h" 
#import "BookRepository.h"

#import "ReadingViewController.h"

@interface ViewController ()


@property (nonatomic, strong) UITableView* bookListView;
@property (nonatomic, strong) BookRepository* bookRep;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    self.bookRep = [[BookRepository alloc ] init];
    [self.bookRep loadBooks];
    self.bookListView = [[UITableView alloc] initWithFrame: self.view.frame style:UITableViewStylePlain];
    self.bookListView.dataSource = self;
    self.bookListView.delegate = self;
    
    [self.view addSubview: self.bookListView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadingViewController* vc = [[ReadingViewController alloc] init];
   
    if(indexPath.row > [self.bookRep.bookArray count]) {
        return;
    }
    
    Book* book = self.bookRep.bookArray[indexPath.row];
    vc.readingSession = [[ReadingSession alloc] init];
    vc.readingSession.currentBook = book;
    
    [self presentViewController:vc animated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.bookRep.bookArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"BookCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"BookCell"];
        Book* book = (Book*)self.bookRep.bookArray[indexPath.row];
        cell.textLabel.text = book.bookName;
    }
    return cell;
}




@end
