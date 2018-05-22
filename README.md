# ABTestSDK
一个用来灰度控制app功能的pod模块

其中redis里面存储的配置会在app 进入前台的时候sync一次，命中生效是app主动拉取的。

在appdelegate里面初始化：

`\- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {`

​    // Override point for customization after application launch.

​    [[ABTestManager sharedInstance] initFeature];

​    return YES;

`}`

使用某个key是否生效：

[[ABTestManager sharedInstance] isFeatuerEnable:@"test"] 