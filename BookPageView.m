//
//  BookPageView.m
//  MyReader
//
//  Created by mac on 10/20/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "BookPageView.h"
#import "CoreText/CoreText.h"
#import "MyReader-swift.h"


@implementation BookPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    
    self.backgroundColor = [UIColor whiteColor];

    /*NSMutableAttributedString *mattrString =
    [[NSMutableAttributedString alloc] initWithString:self.pageContent];

    [mattrString beginEditing];

    
    NSMutableDictionary* attr = [NSMutableDictionary dictionaryWithObject: [UIColor blueColor] forKey:(id)NSForegroundColorAttributeName];
  
   
    UIFont* font = [UIFont systemFontOfSize :54];
    [attr setObject: font forKey: NSFontAttributeName];
    
    [mattrString setAttributes: attr range:NSMakeRange(0,  [mattrString length])];
    
    
    [mattrString endEditing];
     
     */

    NSUInteger count = [self.pageContent length];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFAttributedStringRef)self.pageContent);
   
    Config* config = [Config sharedObject];
    CGRect framerect= [config getPageTextRectWithFrame: [UIScreen mainScreen].bounds ];
    CGMutablePathRef path = CGPathCreateWithRect(framerect, nil);
    //CGRect framerect = CGRectMake(0, 20, self.frame.size.width   ,self.frame.size.height-120);
    //CGMutablePathRef path = CGPathCreateWithRect(CGRectMake(0, 20, self.frame.size.width   ,self.frame.size.height-20) , nil);
    
    //CGMutablePathRef path = CGPathCreateWithRect( framerect, nil);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,0), path, NULL);
    
    
    CGContextRef context  = UIGraphicsGetCurrentContext();
    
    //background
    UIGraphicsPushContext(context);
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    UIGraphicsPopContext();
    //end
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSaveGState(context);
    
    CGAffineTransform transform = CGAffineTransformMake(1,0,0,-1,0, self.frame.size.height);
    CGContextConcatCTM(context, transform);
    
    //CGContextScaleCTM(context, 1.0 ,-1.0);
    CTFrameDraw(frame, context);
    
    CGPathRelease(path);
    CFRelease(framesetter);

}

@end
