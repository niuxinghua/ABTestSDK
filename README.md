# ABTestSDK
## 一个用来灰度控制app功能的pod模块

### 使用方式 pod "NXHABTest"

##### 其中redis里面存储的配置会在app 进入前台的时候sync一次，命中生效是app主动拉取的,对于高频用户来说足够接近实时命中配置，对于低频用户 who care。遇到重大bug，可以规避一系列的风险，前提是AB本身不会引入更多bug。。。。这个不能保证啊！对于引导流量，目前只有全量下发，或者不发，没有类似nginx的权重导流，对于端上来说这是需要具体逻辑控制的，无能为力。

```
在appdelegate里面初始化：

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[ABTestManager sharedInstance] initFeature];**

  return YES;

}
```



> ```
> 使用某个key是否生效：
> 
> [[ABTestManager sharedInstance] isFeatureEnable:@"test"] 
> ```
>

 > ```
 > 
 > ```

#### TODO:后台页面登录与鉴权，编辑灰度列表功能。。。。初步设想是走一个鉴权，根据权限去拉自己的配置。