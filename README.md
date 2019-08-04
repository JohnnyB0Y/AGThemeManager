# AGThemeManager
### APP动态主题切换
###### 主题包管理，动态更新全局主题元素

#### 1，通过派生子类生成主题包，有3中方式生成主题包
 
 - 工程中
 派生 AGThemePack 的子类，重写初始化方法 -initWithPackName: 并配置主题元素；
 每个子类就是不同的主题包
 
 - 本地文件
 派生 AGThemePack 的子类，重写初始化方法 -initWithContentOfFile: 并配置主题元素；
 
 - 网络
 派生 AGThemePack 的子类，重写初始化方法 -initWithThemePackData: 并配置主题元素；

 
 
#### 2，在UI类中使用主题包
 - 调用 -ag_setupAndExecuteThemeUsingBlock: 方法，添加设置Block并执行；
 - 需要注意的是，在Block 中注意循环引用问题；
 - 其实不需要手动移除设置Block，在类dealloc 后，会自动移除Block；
 

#### 3，初始化配置
 - 在 AppDelegate 中，初始化视图界面之前配置好要使用的主题；

 ```objective-c
// 配置主题
 AGThemePackBox *themePackBox = [AGThemePackBox newWithCurrentTheme:kAGOrangeThemePack];
 [themePackBox ag_registerThemePack:[AGOrangeThemePack newWithPackName:kAGOrangeThemePack]];
 [themePackBox ag_registerThemePack:[AGPurpleThemePack newWithPackName:kAGPurpleThemePack]];
 [themePackBox ag_registerThemePack:[AGBlueThemePack newWithPackName:kAGBlueThemePack]];
 [AGThemeManager sharedInstance].themePackBox = themePackBox;
 
 // 打开调试日志
 [AGThemeManager sharedInstance].openLog = YES;
```


