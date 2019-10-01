# AGThemeManager

### Cocoapods 集成
``` objective-c
platform :ios, '8.0'
target 'AGThemeManager' do

pod 'AGThemeManager', '~> 0.1.0'

end
```

### APP动态主题切换
###### 主题包管理，动态更新全局主题元素
###### 对系统动态字体添加了支持
###### 对系统黑暗模式添加了支持

#### 1，通过派生子类生成主题包，有3中方式生成主题包
 
 - 工程中
 派生 AGThemePack 的子类，重写初始化方法 -initWithPackName: 并配置主题元素；
 每个子类就是不同的主题包
 
 - 本地文件
 派生 AGThemePack 的子类，重写初始化方法 -initWithContentOfFile: 并配置主题元素；
 
 - 网络
 派生 AGThemePack 的子类，重写初始化方法 -initWithThemePackData: 并配置主题元素；

 ```objective-c
// 参考 项目中 Demo/CustomTheme 下的自定义类
AGBlueThemePack
AGOrangeThemePack
AGPurpleThemePack
AGFileThemePack
AGDataThemePack
  ```
  
 
#### 2，在UI类中使用主题包
 
 ```objective-c
 ###### 在UI类中添加对主题的支持 #######
 /// 添加主题支持
- (void)ag_themeSupport;

/// 添加主题支持并执行修改
- (void)ag_themeSupportAndExecute;

/// 移除主题支持
- (void)ag_themeRemoveSupport;

/// 执行主题修改
- (void)ag_themeExecute;


 ###### 重写系统特征变化方法，设置变化后的数据 #######
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.textLabel.font = [UIFont ag_themeWithDynamicFontForKey:kAGThemePackHomeCellContentTextFont];
    self.textLabel.textColor = [UIColor ag_themeForKey:kAGThemePackHomeCellContentTextColor];
    self.imageView.image = [UIImage ag_themeForKey:kAGThemePackHomeCellIconImageName];
}

 ```


#### 3，初始化配置
 - 在 AppDelegate 中，初始化视图界面之前配置好要使用的主题；

 ```objective-c
// 配置主题
    AGThemeCollection *themeCollection = [AGThemeCollection newWithDefaultTheme:kAGOrangeThemePack];
    [themeCollection ag_registerThemePack:[AGOrangeThemePack newWithPackName:kAGOrangeThemePack]];
    [themeCollection ag_registerThemePack:[AGPurpleThemePack newWithPackName:kAGPurpleThemePack]];
    [themeCollection ag_registerThemePack:[AGBlueThemePack newWithPackName:kAGBlueThemePack]];
    [themeCollection ag_registerThemePack:[AGDarkThemePack newWithPackName:kAGDarkThemePack]]; // 黑暗模式
    [AGThemeManager sharedInstance].themeCollection = themeCollection;
    // 打开调试日志
    [AGThemeManager sharedInstance].openLog = YES;
    
    // 指定黑暗模式的主题包名
    [AGThemeManager sharedInstance].systemDarkThemeName = kAGDarkThemePack; 
```

#### 4，补充
- Demo 有完整使用方式
- [思路回顾](https://www.jianshu.com/p/03858c4fdc1f)



