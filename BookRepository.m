//
//  BookRepository.m
//  MyReader
//
//  Created by mac on 10/18/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import "BookRepository.h"



@interface BookRepository()

@property (nonatomic, strong, readwrite) NSArray *bookArray;


@end



@implementation BookRepository




-(void) loadBooks {
   
    NSString* indexFilePath = [[NSBundle mainBundle] pathForResource: @"index"
                                                         ofType: @"json"
                                                    inDirectory: @"bookrepository.bundle/books"];
    
    NSData *indexData = [NSData dataWithContentsOfFile:indexFilePath];
    
    if(indexData == nil) {
        return;
    }
   
    NSError *error = [[NSError alloc] init];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:indexData
                                                             options: kNilOptions
                                                               error: &error];
    
    NSArray* jsBookArray = [jsonDict objectForKey:@"books"];
    if(jsBookArray == nil) {
        return;
    }
   
    NSMutableArray* bookMutableArray = [[NSMutableArray alloc] initWithCapacity: [jsBookArray count]];
    for( NSDictionary* jsBookItem in jsBookArray) {
        if(![jsBookItem isKindOfClass: [NSDictionary class]]) {
            continue;
        }
        
        
        Book* book = [[Book alloc] init];
        book.bookName = [jsBookItem objectForKey: @"name"];
        book.catalog = [jsBookItem objectForKey: @"contents"];
        if(![book.catalog isKindOfClass: [NSArray class]]) {
            continue;
        }
        NSString* fileName = [jsBookItem objectForKey: @"file_name"];
        NSString* fileType = [jsBookItem objectForKey: @"file_type"];
        NSString* filePath = [[NSBundle mainBundle] pathForResource: fileName
                                                ofType:fileType
                                                    inDirectory: @"bookrepository.bundle/books"];
        book.filePath = filePath;
        //book.fileHandle = [NSFileHandle fileHandleForReadingAtPath: filePath];
        [bookMutableArray addObject: book];
    }
 
    self.bookArray = [bookMutableArray copy];
    /*
    NSArray* array = [[NSBundle mainBundle] pathsForResourcesOfType: @"txt" inDirectory:@"bookrepository.bundle/books"];
    
    if(array == nil){
        return;
    }
    
    
    
    NSMutableArray* bookMutableArray = [[NSMutableArray alloc] initWithCapacity: [array count]];
    for(NSString* filePath in array) {
        Book* book = [[Book alloc] init];
        book.bookName = [filePath lastPathComponent];
        book.fileHandle = [NSFileHandle fileHandleForReadingAtPath: filePath];
        [bookMutableArray addObject: book];
    }
    
    self.bookArray = [bookMutableArray copy];
    
    return;
    
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource: @"天龙八部utf8" ofType:@"txt" ];
    if(!filePath) {
        return;
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(!fileHandle) {
        return;
    }
    
    NSData* data = [fileHandle readDataToEndOfFile];
    NSUInteger len = [data length];
*/

}



@end
