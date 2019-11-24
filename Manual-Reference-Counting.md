# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```
    ---Answers---
    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    
    
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    
    
    wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
    
    
2. Rewrite the code so that it does not leak any memory with ARC disabled

    ---Answers---
```swift
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count) {
        wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
        wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);

- (void)dealloc {
    [_punctuationSet release]; //retain above
    [_wordFrequency release]; //alloc/init above
    [super dealloc];  //only for manual ARC
}

```

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
	-autoreleased /  it is not retained so this is not an object that we are responsible for the release
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
        -autoreleased /  even though it is alloc/init which means we are responsible for the release, there is autorelease at the end of alloc/init so it will get autoreleased
        
3. Explain when you need to use the `NSAutoreleasePool`.

      ---Answers---
      Even when you follow the MRC rules to release/autorelease to avoid memory leaks, codes that create temporary
      objects such as in a loop can cause memory leak issue. we use NSAutoreleasePool to fix this issue.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end
```
---Answers---

#import "LSIPerson.h"

@implementation LSIPerson

+  (instancetype)initWithName:(NSString *)name
{
    LSIPerson *person = [[[LSIPerson alloc] initWithName: name] autorelease];
    return person
}

@end
