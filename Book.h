//
//  Book.h
//  MyReader
//
//  Created by mac on 10/19/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic) NSString* bookName;
@property (nonatomic, strong) NSArray* catalog;
//@property (nonatomic, strong) NSFileHandle* fileHandle;
@property (nonatomic, strong) NSString* filePath;

@property (nonatomic, readonly) NSString* content;
@end
 
