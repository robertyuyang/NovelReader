//
//  BookRepository.h
//  MyReader
//
//  Created by mac on 10/18/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

          
           
           
@interface BookRepository : NSObject

@property (nonatomic, strong, readonly) NSArray *bookArray;

-(void) loadBooks;

@end
