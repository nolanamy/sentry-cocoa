//
//  SentryNSDataCompressionTests.m
//  Sentry
//
//  Created by Daniel Griesser on 08/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Sentry/Sentry.h>
#import "NSData+Compression.h"

@interface SentryNSDataCompressionTests : XCTestCase

@end

@implementation SentryNSDataCompressionTests

- (void)testCompress {
    NSUInteger numBytes = 1000000;
    NSMutableData *data = [NSMutableData dataWithCapacity:numBytes];
    for (NSUInteger i = 0; i < numBytes; i++) {
        unsigned char byte = (unsigned char) i;
        [data appendBytes:&byte length:1];
    }

    NSError *error = nil;
    NSData *original = [NSData dataWithData:data];
    NSData *compressed = [original gzipped];
    XCTAssertNil(error);
    XCTAssertNotNil(compressed);
}

- (void)testCompressEmpty {
    NSError *error = nil;
    NSData *original = [NSData data];
    NSData *compressed = [original gzipped];
    XCTAssertNil(error, @"");

    XCTAssertEqualObjects(compressed, original, @"");
}

- (void)testCompressNilError {
    NSUInteger numBytes = 1000;
    NSMutableData *data = [NSMutableData dataWithCapacity:numBytes];
    for (NSUInteger i = 0; i < numBytes; i++) {
        unsigned char byte = (unsigned char) i;
        [data appendBytes:&byte length:1];
    }

    NSData *original = [NSData dataWithData:data];
    NSData *compressed = [original gzipped];
    XCTAssertNotNil(compressed);
}

- (void)testCompressEmptyNilError {
    NSData *original = [NSData data];
    NSData *compressed = [original gzipped];

    XCTAssertEqualObjects(compressed, original, @"");
}

@end
