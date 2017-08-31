#import "cloudKitId.h"
#import <Cordova/CDV.h>
#import <CloudKit/CloudKit.h>


@implementation CloudKitId

- (void)getCloudKitId:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult* pluginResult = nil;

    NSString* containerName = [command.arguments objectAtIndex:0];

    if (containerName == nil || [containerName length] == 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
            messageAsString:@"No container name given."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
        @try {
            CKContainer *container = [CKContainer containerWithIdentifier:containerName];
            [container fetchUserRecordIDWithCompletionHandler:^(CKRecordID *recordID, NSError *error) {
               if (error) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                    messageAsString:error.localizedDescription];
               }
               else {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                    messageAsString:recordID.recordName];
               }
            }];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                messageAsString:exception.reason];
        }
        @finally {
           [self.commandDelegate sendPluginResult:pluginResult
            callbackId:command.callbackId];
        }
    }
}

@end