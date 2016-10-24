//
//  BookPageViewController.h
//  MyReader
//
//  Created by mac on 10/21/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookPageViewController : UIViewController

@property (nonatomic, strong) NSAttributedString* pageContent;
@property (nonatomic) NSUInteger pageIndex;


-(instancetype) initWithPageContent: (NSAttributedString*) pageContent
                       AndPageIndex:(NSUInteger) pageIndex;
@end
