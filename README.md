***************
WARNING: THIS PROJECT IS DEPRECATED
====================================
It will not receive any future updates or bug fixes. If you are using it, please migrate to another solution.
***************


Purpose
--------------

FXJSON is a lightweight, reasonably fast JSON parser for iOS and Mac OS. It's not the fastest but it's fast enough (see performance benchmarks below), and it has some neat features:

- Optional SAX-style parsing for large files or where order matters
- Fully ARC compatible (also works without ARC)
- Simple - just one class and the code is easy to understand
- No compiler warnings
- Can optionally strip null values from dictionaries or arrays
- Can optionally use NSJSONSerialization on iOS 5 and above
- Can handle JSON with dangling commas in arrays/objects


Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 6.1 / Mac OS 10.8 (Xcode 4.6, Apple LLVM compiler 4.2)
* Earliest supported deployment target - iOS 5.0 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

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
    
This option will disable generation of NSNull objects for null values inside JSON {...} objects. This is often desirable because a program that receives an NSNull when it expects another object type may crash, whereas no value (nil) is usually handled gracefully. With this option enabled, null values in arrays will still output as NSNull because removing these would affect the array indexes. Defaults to YES. Does not apply when using delegate-based enumeration.

    FXJSON_OMIT_NULL_ARRAY_VALUES
    
This option will disable generation of NSNull objects for null values inside JSON [...] arrays. This is often desirable because a program that receives an NSNull when it expects another object type may crash. Defaults to NO because it might mess up the expected array indexes or item count. Does not apply when using delegate-based enumeration.

    FXJSON_USE_NSJSON_IF_AVAILABLE
    
This option will cause FXJSON to make use of the NSJSONSerialization class on iOS5 and above. This is desirable because the NSJSONSerialization class is faster than FXJSON in most benchmarks. Does not apply when using delegate-based enumeration.


Methods
----------------

FXJSON has the following static methods:

    + (void)enumerateJSONData:(NSData *)data withDelegate:(id<FXJSONDelegate>)delegate;

Parses JSON data using a SAX-style parser where the values are returned via a delegate instead of as a hierarchical object. The advantages of this approach are that very large files can be parsed without consuming a lot of memory (because the entire object graph doesn't need to be stored in memory) and that keys within JSON objects (aka dictionaries) are guaranteed to be returned in the same order they appear in the file (the order of keys in an NSDictionary is arbitrary and undocumented). Delegate methods are called synchronously, however the method is thread safe so you can perform the parsing on a background thread to avoid blocking the UI. The FXJSONDelegate methods are documented below.

    + (id)objectWithJSONEncodedString:(NSString *)string;

Parses a string as JSON data and returns the object. Note that this is less efficient than using `objectWithJSONData` as the string must first be converted from UTF16 to UTF8 bytes before parsing.

    + (id)objectWithJSONData:(NSData *)data;

Parses a string of UTF8 JSON data and returns the object.


FXJSONDelegate Methods
-------------------------

    - (void)didStartJSONParsing;
    
This is called immediately before parsing begins.
    
    - (void)didStartJSONArray;
    
This is called when the parser encounters the beginning of a JSON array.
    
    - (void)didStartJSONObject;
    
This is called when the parser encounters the beginning of a JSON object (aka a dictionary).
    
    - (void)didFindJSONKey:(NSString *)key;
    
This is called when the parser encounters a key within a JSON object.
    
    - (void)didFindJSONValue:(id)value;
    
This is called when the parser encounters a value within a JSON object or array (or the root object of the file). Note that this is only called for non-collection type values. When JSON objects or arrays are encountered then the `didStart...` methods will be called instead.
    
    - (void)didEndJSONObject;
    
This is called when the parser encounters the end of a JSON object.
    
    - (void)didEndJSONArray;
    
This is called when the parser encounters the end of a JSON array.
    
    - (void)didEndJSONParsing;
    
This is called when the end of the document is reached. This may not be called in the event of an error being encountered.


Notes
----------------

FXJSON always returns mutable container objects (NSMutableArray or NSDictionary) so you can efficiently manipulate the data after it is returned.

FXJSON always returns *immutable* strings.

FXJSON will accept any root object type as long as it is valid JSON, so the object returned may be an NSMutableDictionary, NSMutableArray, NSString, NSNumber or NSNull.


Performance
-----------------

FXJSON is not the fastest JSON parser, but it's far from the slowest. In stats it ranked 4th out of the 6 most popular 3rd party JSON parsers.

It's worth noting that since FXJSON automatically defaults to using NSJSONSerialization on iOS5, it would actually rank second if that option was enabled (as it is by default).

    JSONKit                     10.942 ms
    NextiveJson                 37.001 ms
    YAJL                        55.896 ms
    FXJSON                      65.618 ms
    SBJson                      78.108 ms
    TouchJSON                  113.995 ms
    
    NSJSONSerialization         32.044 ms

Comparison performed on iOS 5.1 on an iPhone 4S. Tests were conducted with the `FXJSON_OMIT_NULL_OBJECT_VALUES`, `FXJSON_OMIT_NULL_ARRAY_VALUES` and `FXJSON_USE_NSJON_IF_AVAILABLE` options disabled. Check out the benchmark app for yourself here:

https://github.com/nicklockwood/json-benchmarks
