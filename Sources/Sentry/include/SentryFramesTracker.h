#import "SentryDefines.h"

@class SentryOptions, SentryDisplayLinkWrapper;

NS_ASSUME_NONNULL_BEGIN

/**
 * Tracks total, frozen and slow frames for iOS, tvOS, and Mac Catalyst.
 */
@interface SentryFramesTracker : NSObject
SENTRY_NO_INIT

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) NSUInteger currentTotalFrames;
@property (nonatomic, assign, readonly) NSUInteger currentFrozenFrames;
@property (nonatomic, assign, readonly) NSUInteger currentSlowFrames;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
