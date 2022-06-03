#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(ApplePayPlugin, "ApplePay",
           CAP_PLUGIN_METHOD(canMakePayments, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(initiatePayment, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(completeLastPayment, CAPPluginReturnPromise);

)
