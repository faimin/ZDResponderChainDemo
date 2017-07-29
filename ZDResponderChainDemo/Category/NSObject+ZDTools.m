//
//  NSObject+ZDTools.m
//  ZDResponderChainDemo
//
//  Created by Zero.D.Saber on 2017/7/29.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "NSObject+ZDTools.h"

@implementation NSObject (ZDTools)

- (id)zd_getReturnFromInvocation:(NSInvocation *)invocation withSigature:(NSMethodSignature *)sig {
    NSUInteger returnLenght = [sig methodReturnLength];
    if (returnLenght == 0) return nil;
    
    const char *type = [sig methodReturnType];
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
#define return_with_number(_type_) \
do { \
_type_ returnValue; \
[invocation getReturnValue:&returnValue]; \
return @(returnValue); \
} while (0)
    
    switch (*type) {
        case 'v': return nil; // void
        case 'B': return_with_number(bool);
        case 'c': return_with_number(char);
        case 'C': return_with_number(unsigned char);
        case 's': return_with_number(short);
        case 'S': return_with_number(unsigned short);
        case 'i': return_with_number(int);
        case 'I': return_with_number(unsigned int);
        case 'l': return_with_number(int);
        case 'L': return_with_number(unsigned int);
        case 'q': return_with_number(long long);
        case 'Q': return_with_number(unsigned long long);
        case 'f': return_with_number(float);
        case 'd': return_with_number(double);
        case 'D': { // long double
            long double ret;
            [invocation getReturnValue:&ret];
            return [NSNumber numberWithDouble:ret];
        };
            
        case '@': { // id
            void *ret;
            [invocation getReturnValue:&ret];
            return (__bridge id)ret;
        };
            
        case '#': { // Class
            Class ret = nil;
            [invocation getReturnValue:&ret];
            return ret;
        };
            
        default: { // struct / union / SEL / void* / unknown
            const char *objCType = [sig methodReturnType];
            char *buf = calloc(1, returnLenght);
            if (!buf) return nil;
            [invocation getReturnValue:buf];
            NSValue *value = [NSValue valueWithBytes:buf objCType:objCType];
            free(buf);
            return value;
        };
    }
#undef return_with_number

}

@end
