//
//  PRSGlobal.h
//  PusnaRS
//
//  Created by KOSHIDA Takayoshi on 2013/10/02.
//  Copyright (c) 2013年 RSD. All rights reserved.
//

#import <UIKit/UIKit.h>

#if DEBUG && PRS_UNIT_TEST
    #define PRS_STATIC
#else
    #define PRS_STATIC static
#endif

// DEBUG LOG
#if DEBUG
    #define PRSDebugLog(s, ...) NSLog(@"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
    #define PRSDebugLog(s, ...)
#endif

// PRS LOG
#if DEBUG
#define PRSLog(s, ...) {                                                                    \
    if (PRSLogOutput) {                                                                     \
        NSLog(@"[PusnaRS]<%p %@:(%d)> %@",                                                  \
        self,                                                                               \
        [[NSString stringWithUTF8String:__FILE__] lastPathComponent],                       \
        __LINE__,                                                                           \
        [NSString stringWithFormat:(s),                                                     \
        ##__VA_ARGS__]);                                                                    \
    }                                                                                       \
}
#else
#define PRSLog(s, ...) {                                                                    \
    if (PRSLogOutput) {                                                                     \
        NSLog(@"[PusnaRS] %@", [NSString stringWithFormat:(s), ##__VA_ARGS__]);             \
    }                                                                                       \
}
#endif


// SINGLETON INTERFACE
#define PRS_SINGLETON_INTERFACE(CLASSNAME)                                                  \
+ (CLASSNAME*)shared;

// SINGLETON IMPLEMENTATION
#define PRS_SINGLETON_IMPLEMENTATION(CLASSNAME)                                             \
                                                                                            \
static CLASSNAME* g_shared##CLASSNAME = nil;                                                \
                                                                                            \
+ (CLASSNAME*)shared                                                                        \
{                                                                                           \
    static dispatch_once_t sharedOncePredicate##CLASSNAME;                                  \
                                                                                            \
    dispatch_once(&sharedOncePredicate##CLASSNAME, ^{                                       \
        g_shared##CLASSNAME = [[self alloc] init];                                          \
    });                                                                                     \
    return g_shared##CLASSNAME;                                                             \
}                                                                                           \
                                                                                            \
+ (id)allocWithZone:(NSZone*)zone                                                           \
{                                                                                           \
    static dispatch_once_t allocOncePredicate##CLASSNAME;                                   \
    dispatch_once(&allocOncePredicate##CLASSNAME, ^{                                        \
        if (g_shared##CLASSNAME == nil) {                                                   \
            g_shared##CLASSNAME = [super allocWithZone:zone];                               \
        }                                                                                   \
    });                                                                                     \
    return g_shared##CLASSNAME;                                                             \
}                                                                                           \
                                                                                            \
- (id)copyWithZone:(NSZone*)zone                                                            \
{                                                                                           \
    return self;                                                                            \
}

// GLOBALS
extern BOOL PRSLogOutput;
extern BOOL PRSInProduction;
extern NSString *PRSUrlInProduction;
extern NSString *PRSUrlInDevelopment;
extern NSString * const PusnaRSIdentifier;


