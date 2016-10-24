//
//  BookPageViewController.m
//  MyReader
//
//  Created by mac on 10/21/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "BookPageViewController.h"

#import "BookPageView.h"

@interface BookPageViewController ()

@property (nonatomic, strong) BookPageView* bookPageView;
@end

@implementation BookPageViewController

-(instancetype) initWithPageContent: (NSAttributedString*) pageContent
                       AndPageIndex:(NSUInteger) pageIndex {
    self.pageContent = pageContent;
    self.pageIndex = pageIndex;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(self.bookPageView == nil) {
        /*NSUInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        CGRect rect = CGRectMake(0,
                                 statusBarHeight,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - statusBarHeight);
        */
        CGRect rect= [UIScreen mainScreen].bounds;
         self.bookPageView = [[BookPageView alloc] initWithFrame: rect];
        //self.bookPageView.opaque = NO;
        self.bookPageView.pageContent = self.pageContent;
        [self.view addSubview: self.bookPageView];
    }
    
    return;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
