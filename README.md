Purpose
--------------

FXJSON is a lightweight, reasonably fast JSON parser for iOS and Mac OS. It's not the fastest but it's fast enough (see performance benchmarks below), and it has some neat features:

- Fully ARC compatible (also works without ARC)
- Simple - just one class and the code is easy to understand
- No compiler warnings
- Can optionally strip null values from dictionaries
- Can optionally use NSJSONSerialization on iOS 5 and above
- Can handle JSON with dangling commas in arrays/objects


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 5.1 / Mac OS 10.7 (Xcode 4.4.1, Apple LLVM compiler 4.0)
* Earliest supported deployment target - iOS 4.3 / Mac OS 10.6
* Earliest compatible deployment target - iOS 3.0

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

FXJSON automatically supports both ARC and non-ARC projects through conditional compilation. There is no need to exclude FXJSON files from the ARC validation process, or to convert FXJSON using the ARC conversion tool.


Installation
---------------

To use FXJSON, just drag the class files into your project. The FXJSON methods are static so there's no need to create an instance of the FXJSON class.


Configuration
-----------------

FXJSON has the following configurations constants. These can be set as preprocessor macros in the build settings if you wish to override the defaults:

    FXJSON_OMIT_NULL_OBJECT_VALUES
    
This option will disable generation of NSNull objects for null values insider JSON {...} objects. This is often desirable because a program that receives an NSNull when it expects another object type may crash, whereas no value (nil) is usually handled gracefully. With this option enabled, null values in arrays will still output as NSNull because removing these would affect the array indexes. Defaults to YES.

    FXJSON_USE_NSJSON_IF_AVAILABLE
    
This option will cause FXJSON to make use of the NSJSONSerialization class on iOS5 and above. This is desirable because the NSJSONSerialization class is faster than FXJSON in most benchmarks.


Methods
----------------

FXJSON has the following static methods:

    + (id)objectWithJSONEncodedString:(NSString *)string;

Parses a string as JSON data and returns the object. Note that this is less efficient than using `objectWithJSONData` as the string must first be converted from UTF16 to UTF8 bytes before parsing.

    + (id)objectWithJSONData:(NSData *)data;

Parses a string of UTF8 JSON data and returns the object.

	
Notes
----------------

FXJSON always returns mutable container objects (NSMutableArray or NSDictionary) so you can efficiently manipulate the data after it is returned.

FXJSON always returns *immutable* strings.

FXJSON will accept any root object type as long as it is valid JSON, so the object returned may be an NSMutableDictionary, NSMutableArray, NSString, NSNumber or NSNull.


Performance
-----------------

FXJSON is not the fastest JSON parser, but it's far from the slowest. In stats it ranked 4th out of the 6 most popular 3rd party JSON parsers.

It's worth noting that since FXJSON automatically defaults to using NSJSONSerialization on iOS5, it would actually rank second if that option was enabled.

    JSONKit                     10.942 ms
    NextiveJson                 37.001 ms
    YAJL                        55.896 ms
    FXJSON                      65.618 ms
    SBJson                      78.108 ms
    TouchJSON                  113.995 ms
    
    NSJSONSerialization         32.044 ms

Comparison performed on iOS 5.1 on an iPhone 4S. Tests were conducted with the `FXJSON_OMIT_NULL_OBJECT_VALUES` and `FXJSON_USE_NSJON_IF_AVAILABLE` options disabled. Check out the benchmark app for yourself here:

https://github.com/nicklockwood/json-benchmarks