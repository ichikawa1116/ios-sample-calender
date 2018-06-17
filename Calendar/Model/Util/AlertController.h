//
//  AlertController.h
//  Calendar
//
//  Created by Manami Ichikawa on 8/13/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlertController : NSObject

+ (void)validateText:(UIViewController*)viewController
              titleString:(NSString*)titleText
            messageString:(NSString*)messageText
         actionFunc:(void(^)(UIAlertAction *alertAction))actionFunc;

+ (void)confirmDelete:(UIViewController*)viewConrtroller
   titleString:(NSString*)titleString
 messageString:(NSString*)messageString
  okActionFunc:(void(^)(UIAlertAction *action))okActionFunc
cancelActionFunc:(void(^)(UIAlertAction *action))cancelActionFunc;
@end
