//
//  FXJSON.h
//
//  Version 1.0
//
//  Created by Nick Lockwood on 27/10/2009.
//  Copyright 2009 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/FXJSON
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <Foundation/Foundation.h>


#ifndef FXJSON_OMIT_NULL_OBJECT_VALUES
#define FXJSON_OMIT_NULL_OBJECT_VALUES YES
#endif

#ifndef FXJSON_USE_NSJON_IF_AVAILABLE
#define FXJSON_USE_NSJON_IF_AVAILABLE YES
#endif


@interface FXJSON : NSObject

+ (id)objectWithJSONEncodedString:(NSString *)string;
+ (id)objectWithJSONData:(NSData *)data;

@end