//
//  ReadingSession.m
//  MyReader
//
//  Created by mac on 10/19/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "ReadingSession.h"


@interface  ReadingSession()

@property (nonatomic, strong) NSMutableArray* bookMarksArray;

@end

@implementation ReadingSession

-(Boolean) initData {
 
    [self loadLastProgress];
    [self loadBookMarsks];
   // NSData* data = [NSData alloc] initWithContentsOfFile: self.currentBook.fileHandle
    return YES;
}


-(void) saveData {
    
}

-(void) loadLastProgress {
    self.readingProgress = 0.0;
}

-(void) loadBookMarsks {
    
}


@end
