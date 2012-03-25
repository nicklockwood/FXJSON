//
//  JSONTests.m
//
//  Created by Nick Lockwood on 12/01/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//

#import "JSONTests.h"
#import "FXJSON.h"

@implementation JSONTests

- (void)testString
{
    NSString *text = @"Hell no World";
    NSString *json = @"\"Hell no World\"";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"Strings test failed");
}

- (void)testLowUnicode
{
    NSString *text = @"Hello World";
    NSString *json = @"\"He\\u006C\\u006Co \\u0057orld\"";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"Low unicode test failed");
}

- (void)testHighUnicode
{
    NSString *text = @"姓名";
    NSString *json = @"\"\\u59d3\\u540d\"";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"High unicode test failed");
}

- (void)testNumber
{
    double number = -1234.0786754;
    NSString *json = @"-1234.0786754";
    NSAssert(number == [[FXJSON objectWithJSONEncodedString:json] doubleValue], @"Number test failed");
}

- (void)testNull
{
    NSString *json = @"null";
    NSAssert([NSNull null] == [FXJSON objectWithJSONEncodedString:json], @"Null test failed");
}

- (void)testArray
{
    NSArray *text = [NSArray arrayWithObjects:@"Hello", [NSArray arrayWithObjects:@"World", @"Wise", nil], nil];
    NSString *json = @" [ \"Hello\", [\"World\" , \"Wise\"]] ";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"Array test failed");
}

- (void)testDictionary
{
    NSDictionary *text = [NSDictionary dictionaryWithObjectsAndKeys:@"World", @"Hello", @"World", @"Goodbye", nil];
    NSString *json = @" { \"Hello\": \"World\", \"Goodbye\": \"World\"}";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"Dictionary test failed");
}

- (void)testDictionaryWithNullValue
{
    NSDictionary *text = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"World"];
    NSString *json = @"{\"Hello\": null, \"World\": true}";
    NSAssert([text isEqual:[FXJSON objectWithJSONEncodedString:json]], @"Dictionary with null test failed");
}

- (void)testNilInput
{
    NSAssert([FXJSON objectWithJSONEncodedString:nil] == nil, @"Nil string input test failed");
    NSAssert([FXJSON objectWithJSONData:nil] == nil, @"Nil data input test failed");
}

@end