#import "AppDelegate.h"
#import "DateMachine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  [self.window setRootViewController:[DateMachine new]];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
    DateMachine *vc = [[DateMachine alloc] init];
    [_window setRootViewController:vc];
    [vc release];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
