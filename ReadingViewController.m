//
//  ReadingViewController.m
//  MyReader
//
//  Created by mac on 10/19/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "ReadingViewController.h"
//#import "BookPageView.h"
#import "BookPageViewController.h"
#import "MyReader-swift.h"


#import "CoreText/CoreText.h"


@interface ReadingViewController ()



@property (nonatomic, strong) UIFont* font;

@property (nonatomic, strong) BookPageViewController* currentPageVC;

@property (nonatomic, strong) NSMutableArray* rangeOfTextPerPageArray;
@end



@implementation ReadingViewController


-(void) setReadingSession:(ReadingSession *)readingSession {
    _readingSession = readingSession;
    if(readingSession.currentBook != nil) {
        [self calcBookPages];
    }
    
    [readingSession addObserver:self forKeyPath:@"currentBook" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"currentBook"]) {
        [self calcBookPages];
    }
}

-(NSDictionary*) getAttr {
    Config* config = Config.sharedObject;
  
    NSDictionary* attr = [NSDictionary dictionaryWithObjectsAndKeys:
                          NSForegroundColorAttributeName, config.foregroundColor,
                          NSFontAttributeName, config.font,
                          nil];
    return attr;
}
-(void) calcBookPages {
    self.rangeOfTextPerPageArray = [[NSMutableArray alloc] init];
   
    
    NSString* content = self.readingSession.currentBook.content;
    NSMutableAttributedString *mattrString =
    [[NSMutableAttributedString alloc] initWithString:content
                                           attributes: [self getAttr]];
  
    
    Config* config = Config.sharedObject;

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mattrString);
    
    CGRect rect= [config getPageTextRectWithFrame: [UIScreen mainScreen].bounds ];
    CGMutablePathRef path =
    CGPathCreateWithRect(rect, nil);
    
    Boolean calcFinished = NO;
    NSUInteger currentOffset = 0;
    
    /*
     private func calculateBookSumPageNumber() {
     let contentAttr = self.contentAttribute(readRecord.fontSize);
     let currentOffsetContent = String(self.bookContent);
     let contentAttrString = NSMutableAttributedString(string: currentOffsetContent);
     contentAttrString.setAttributes(contentAttr, range: NSMakeRange(0, contentAttrString.length));
     let frameSetter = CTFramesetterCreateWithAttributedString(contentAttrString);
     let path = CGPathCreateWithRect(CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds) - WHC_LookBookVC.kPading * 2, CGRectGetHeight(UIScreen.mainScreen().bounds) - WHC_LookBookVC.kPading * 4), nil);
     while !calculatePageEnd {
     let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(Int(currentContentOffset), 0), path, nil);
     let range = CTFrameGetVisibleStringRange(frame);
     let pageRange = NSMakeRange(Int(currentContentOffset), range.length);
     pageRangeContentArr.addObject(NSValue(range: pageRange));
     if ((range.location + range.length) != contentAttrString.length){
     currentContentOffset += UInt64(range.length)
     }else {
     calculatePageEnd = true;
     currentContentOffset += UInt64(range.length);
     }
     }
     }*/
    
    while(!calcFinished) {
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(currentOffset, 0), path, nil);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        NSValue* value = [NSValue valueWithRange: NSMakeRange(currentOffset, range.length)];
        [self.rangeOfTextPerPageArray addObject: value];
        if((range.location + range.length) == mattrString.length) {
            calcFinished = YES;
        }
        
        currentOffset += range.length;
    }
    
    
    
}

- (NSUInteger) getPageCount {
    return [self.rangeOfTextPerPageArray count];
}

- (NSUInteger) getPageIndexByProgress: (Progress) progress {
    NSUInteger pageCount = [self getPageCount];
    return (pageCount * progress);
}

-(NSAttributedString*) getPageContentOfPageIndex: (NSUInteger) pageIndex {
    if(pageIndex >= [self.rangeOfTextPerPageArray count]) {
        return nil;
    }
    NSString* content = self.readingSession.currentBook.content;
    NSAttributedString *attrString =
    [[NSAttributedString alloc] initWithString:content
                                           attributes: [self getAttr]];
    
    NSValue* value = self.rangeOfTextPerPageArray[pageIndex];
    NSRange range = value.rangeValue;
    return [attrString attributedSubstringFromRange: range];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.readingSession) {
        if(![self.readingSession initData])
        {
            return;
        }
    }
   
    UIPageViewController* pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    NSUInteger pageIndex = [self getPageIndexByProgress: self.readingSession.readingProgress];
    
    self.currentPageVC = [[BookPageViewController alloc]
                          initWithPageContent:[self getPageContentOfPageIndex: pageIndex]
                          AndPageIndex:pageIndex];
    
    [pageVC setViewControllers: @[self.currentPageVC] direction:UIPageViewControllerNavigationDirectionForward animated: YES completion:nil];
   
    
    pageVC.dataSource = self;
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
  
    BookPageViewController* currentPageVC = (BookPageViewController*)viewController;
    NSUInteger currentPageIndex = currentPageVC.pageIndex;
    if(currentPageIndex == 0) {
        
        return nil;
    }
    else{
     return [[BookPageViewController alloc]
                          initWithPageContent:[self getPageContentOfPageIndex: currentPageIndex - 1]
                          AndPageIndex:currentPageIndex - 1];
        
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    BookPageViewController* currentPageVC = (BookPageViewController*)viewController;
    NSUInteger currentPageIndex = currentPageVC.pageIndex;
    NSUInteger pageCount = [self getPageCount];
    if(currentPageIndex == pageCount - 1) {
        return nil;
    }
    else{
     return [[BookPageViewController alloc]
                          initWithPageContent:[self getPageContentOfPageIndex: currentPageIndex + 1]
                          AndPageIndex:currentPageIndex + 1];
        
    }
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
