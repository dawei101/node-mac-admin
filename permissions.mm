#include <napi.h>

#import <Foundation/Foundation.h>
#import <Security/Authorization.h>
#import <Security/AuthorizationTags.h>

Napi::Promise AskForAdminPrivilege(const Napi::CallbackInfo &info) {
  Napi::Env env = info.Env();
  Napi::Promise::Deferred deferred = Napi::Promise::Deferred::New(env);

  std::string appId = info[0].As<Napi::String>().Utf8Value();

  OSStatus status;
  AuthorizationRef authorizationRef;

  // Create the authorization reference
  status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment,
                               kAuthorizationFlagDefaults, &authorizationRef);

  if (status != errAuthorizationSuccess) {
    deferred.Reject(Napi::String::New(env, "AuthorizationCreate failed"));
  } else {

    // Set the rights that you want to request
    AuthorizationItem authItem = {appId.c_str(), 0, NULL, 0};
    AuthorizationRights authRights = {1, &authItem};

    // Request authorization
    status = AuthorizationCopyRights(
        authorizationRef, &authRights, kAuthorizationEmptyEnvironment,
        kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed |
            kAuthorizationFlagPreAuthorize,
        NULL);
    if (status != errAuthorizationSuccess) {
      NSLog(@"AuthorizationCopyRights failed with status %d", (int)status);
      AuthorizationFree(authorizationRef, kAuthorizationFlagDestroyRights);
      deferred.Reject(Napi::String::New(env, "AuthorizationCopyRights failed"));
    } else {
      // Use the authorization reference to perform privileged operations
      NSLog(@"You now have administrative privileges!");
      Napi::Object result = Napi::Object::New(env);
      result.Set(Napi::String::New(env, "status"),
                 Napi::Number::New(env, status));
      deferred.Resolve(result);
    }
  }

  // Free the authorization reference
  AuthorizationFree(authorizationRef, kAuthorizationFlagDestroyRights);
  return deferred.Promise();
}

// Initializes all functions exposed to JS
Napi::Object Init(Napi::Env env, Napi::Object exports) {
  exports.Set(Napi::String::New(env, "askForAdminPrivilege"),
              Napi::Function::New(env, AskForAdminPrivilege));

  return exports;
}

NODE_API_MODULE(permissions, Init)
