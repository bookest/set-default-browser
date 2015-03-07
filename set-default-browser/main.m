//
//  main.m
//  set-default-browser
//
//  Created by Christopher Grim on 6/26/12.
//  Copyright (c) 2012 Christopher Grim. All rights reserved.
//

#import <Foundation/Foundation.h>

static void setDefaultBrowser(NSBundle *bundle)
{
    // AFAICT when you change the default browser via Safari's
    // preferences it changes the default handler for the following
    // URL schemes:
    NSArray *schemes = [NSArray arrayWithObjects:@"http", @"https", nil];
    // and the following content types:
    NSArray *contentTypes = [NSArray arrayWithObjects:@"public.html", @"public.xhtml", nil];

    NSString *bundleId = [bundle bundleIdentifier];
    OSStatus result;

    for (NSString *scheme in schemes) {
        result = LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)scheme,
                                                 (__bridge CFStringRef)bundleId);
    }

    for (NSString *contentType in contentTypes) {
        result = LSSetDefaultRoleHandlerForContentType((__bridge CFStringRef)contentType,
                                                       kLSRolesAll,
                                                       (__bridge CFStringRef)bundleId);
    }
}

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *path = [NSString stringWithFormat: @"%s", argv[1]];
        NSBundle *bundle = [[NSBundle alloc] initWithPath: path];
        setDefaultBrowser(bundle);
    }

    return 0;
}
