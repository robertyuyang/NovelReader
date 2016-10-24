//
//  Book.m
//  MyReader
//
//  Created by mac on 10/19/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "Book.h"

@interface Book()

@property (nonatomic, readwrite) NSString* content;

@end

@implementation Book


-(NSString*) content {
    if(_content == nil) {
        if(self.filePath == nil) {
            return nil;
        }
        
        _content = [NSString stringWithContentsOfFile: self.filePath
                                             encoding:NSUTF8StringEncoding error:nil];
    }
    return _content;
}


@end
