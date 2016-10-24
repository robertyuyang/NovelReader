//
//  ReadingSession.h
//  MyReader
//
//  Created by mac on 10/19/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"



typedef double Progress;

@interface ReadingSession : NSObject

@property (nonatomic, strong) Book* currentBook;
@property (nonatomic) double readingProgress;
//@property (nonatomic, strong) NSString* currentBookContent;


-(Boolean) initData;
-(void) saveData;
@end
