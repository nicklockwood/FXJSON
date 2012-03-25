//
//  main.m
//  URLUtilsTests
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONTests.h"


int main (int argc, const char * argv[])
{
    @autoreleasepool 
	{
        
        //test string functions
        [[[JSONTests alloc] init] runTests];
                
    }
    return 0;
}

