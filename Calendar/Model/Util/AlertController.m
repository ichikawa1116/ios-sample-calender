//
//  AlertController.m
//  Calendar
//
//  Created by Manami Ichikawa on 8/13/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "AlertController.h"
#import "StringDefinition.h"

@implementation AlertController

+ (void)validateText:(UIViewController*)vc
         titleString:(NSString*)titleString
       messageString:(NSString*)messageString
          actionFunc:(void(^)(UIAlertAction *alertAction))actionFunc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleString
                         message:messageString
                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:OkButton
                             style:UIAlertActionStyleDefault
                           handler:actionFunc];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}


+ (void)confirmDelete:(UIViewController*)viewConrtroller
   titleString:(NSString*)titleString
 messageString:(NSString*)messageString
  okActionFunc:(void(^)(UIAlertAction *action))okActionFunc
cancelActionFunc:(void(^)(UIAlertAction *action))cancelActionFunc
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleString
                                                                             message:messageString
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:CancelButton
                             style:UIAlertActionStyleCancel
                           handler:cancelActionFunc];
    [alertController addAction:cancelAction];
    
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:OkButton
                             style:UIAlertActionStyleDefault
                           handler:okActionFunc];
    [alertController addAction:okAction];
    [viewConrtroller presentViewController:alertController animated:YES completion:nil];
}

@end
