//
//  MYPlatformAPIDefines.h
//  MobilePlatform
//
//  Created by Simon Dai on 4/17/14.
//  Copyright (c) 2014 Mysoft. All rights reserved.
//

#ifndef MobilePlatform_MYPlatformAPIDefines_h
#define MobilePlatform_MYPlatformAPIDefines_h

#define kPlatformBundleID                           @"com.mysoft.mobileplatform"
#define kPlatformURLSchemes                         @"com.mysoft.mobileplatform"
#define kPlatformPasteboard_Login                   @"com.mysoft.mobileplatform.pasteboard.login"
#define kPlatformPasteboard_GestureLockUsers        @"com.mysoft.mobileplatform.pasteboard.gestureLockUsers"
#define kPlatformPasteboard_PlatformVersion         @"com.mysoft.mobileplatform.pasteboard.platformVersion"

#define kPlatformPasteboard_GestureCode             @"com.mysoft.mobileplatform.pasteboard.gestureCode"

#define kPlatformPasteboard_EnterBackgroundTime     @"com.mysoft.mobileplatform.pasteboard.enterBackgroundTime"
#define kPlatformPasteboard_GestureLockTime         @"com.mysoft.mobileplatform.pasteboard.gestureLockTime"
#define kGestureLockTime                            @"com.mysoft.mobileplatform.gestureLockTime"

#define kPlatformMysoftDESKEY                       @"Mysoft95938"

#define kPlatformResourceBundle                     @"APIResource.bundle"

#define isIOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define isIOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#endif
