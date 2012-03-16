//
//  WZKeyChain.m
//  WZFoundation
//
//  Created by Menno on 15-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

//
//  WZKeyChain.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright (c) 2009-2011 Sam Soffes. All rights reserved.
//

#import "WZKeyChain.h"

NSString *const kWZKeyChainErrorDomain = @"com.samsoffes.WZKeyChain";

NSString *const kWZKeyChainAccountKey = @"acct";
NSString *const kWZKeyChainCreatedAtKey = @"cdat";
NSString *const kWZKeyChainClassKey = @"labl";
NSString *const kWZKeyChainDescriptionKey = @"desc";
NSString *const kWZKeyChainLabelKey = @"labl";
NSString *const kWZKeyChainLastModifiedKey = @"mdat";
NSString *const kWZKeyChainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE  
CFTypeRef WZKeyChainAccessibilityType = NULL;
#endif

@interface WZKeyChain ()
+ (NSMutableDictionary *)_queryForService:(NSString *)service account:(NSString *)account;
@end

@implementation WZKeyChain

#pragma mark - Getting Accounts

+ (NSArray *)allAccounts {
    return [self accountsForService:nil error:nil];
}


+ (NSArray *)allAccounts:(NSError **)error {
    return [self accountsForService:nil error:error];
}


+ (NSArray *)accountsForService:(NSString *)service {
    return [self accountsForService:service error:nil];
}


+ (NSArray *)accountsForService:(NSString *)service error:(NSError **)error {
    OSStatus status = WZKeyChainErrorBadArguments;
	CFArrayRef result = NULL;
    NSMutableDictionary *query = [self _queryForService:service account:nil];
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:kWZKeyChainErrorDomain code:status userInfo:nil];
	}
    return (__bridge_transfer NSArray *)result;
}


#pragma mark - Getting Passwords

+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account {
	return [self passwordForService:service account:account error:nil];
}


+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account error:(NSError **)error {
    OSStatus status = WZKeyChainErrorBadArguments;
	NSString *result = nil;
	if (service && account) {
		CFDataRef data = NULL;
		NSMutableDictionary *query = [self _queryForService:service account:account];
		[query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
		[query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
		status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&data);
		if (status == noErr && CFDataGetLength(data) > 0) {
			result = [[NSString alloc] initWithData:(__bridge_transfer NSData *)data encoding:NSUTF8StringEncoding];
		}
	}
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:kWZKeyChainErrorDomain code:status userInfo:nil];
	}
	return result;
}


#pragma mark - Deleting Passwords

+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account {
	return [self deletePasswordForService:service account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account error:(NSError **)error {
	OSStatus status = WZKeyChainErrorBadArguments;
	if (service && account) {
		NSMutableDictionary *query = [self _queryForService:service account:account];
		status = SecItemDelete((__bridge CFDictionaryRef)query);
	}
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:kWZKeyChainErrorDomain code:status userInfo:nil];
	}
	return (status == noErr);
    
}


#pragma mark - Setting Passwords

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account {
	return [self setPassword:password forService:service account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account error:(NSError **)error {
	OSStatus status = WZKeyChainErrorBadArguments;
	if (password && service && account) {
        [self deletePasswordForService:service account:account];
        NSMutableDictionary *query = [self _queryForService:service account:account];
        [query setObject:[password dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
		
#if __IPHONE_4_0 && TARGET_OS_IPHONE
		if (WZKeyChainAccessibilityType) {
			[query setObject:(id)[self accessibilityType] forKey:(__bridge id)kSecAttrAccessible];
		}
#endif
		
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
	}
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:kWZKeyChainErrorDomain code:status userInfo:nil];
	}
	return (status == noErr);
}


#pragma mark - Configuration

#if __IPHONE_4_0 && TARGET_OS_IPHONE 
+ (CFTypeRef)accessibilityType {
	return WZKeyChainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
	CFRetain(accessibilityType);
	if (WZKeyChainAccessibilityType) {
		CFRelease(WZKeyChainAccessibilityType);
	}
	WZKeyChainAccessibilityType = accessibilityType;
}
#endif


#pragma mark - Private

+ (NSMutableDictionary *)_queryForService:(NSString *)service account:(NSString *)account {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	
    if (service) {
		[dictionary setObject:service forKey:(__bridge id)kSecAttrService];
	}
	
    if (account) {
		[dictionary setObject:account forKey:(__bridge id)kSecAttrAccount];
	}
	
    return dictionary;
}

@end
