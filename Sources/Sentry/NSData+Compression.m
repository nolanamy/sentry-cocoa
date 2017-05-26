//
//  NSData+Compression.m
//  Sentry
//
//  Created by Daniel Griesser on 08/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/NSData+Compression.h>
#import <Sentry/SentryError.h>
#import <Sentry/miniz.h>

#else
#import "NSData+Compression.h"
#import "SentryError.h"
#import "miniz.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@implementation NSData (Compression)

- (NSData *_Nullable)gzipped {
    uInt length = (uInt) [self length];
    if (length == 0) {
        return [NSData data];
    }

    /// Init empty z_stream
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.next_in = (Bytef *) (void *) self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    stream.avail_in = length;
    
    int err = 0;
    
    deflateInit2(&stream, 7, Z_DEFLATED, Z_DEFAULT_WINDOW_BITS, 9, Z_DEFAULT_STRATEGY);

    NSMutableData *compressedData = [NSMutableData dataWithLength:(NSUInteger) (length * 1.02 + 50)];
    Bytef *compressedBytes = [compressedData mutableBytes];
    NSUInteger compressedLength = [compressedData length];

    /// compress
    while (err == Z_OK) {
        stream.next_out = compressedBytes + stream.total_out;
        stream.avail_out = (uInt) (compressedLength - stream.total_out);
        err = deflate(&stream, Z_FINISH);
    }

    [compressedData setLength:stream.total_out];

    deflateEnd(&stream);
    return compressedData;
}

@end

NS_ASSUME_NONNULL_END
