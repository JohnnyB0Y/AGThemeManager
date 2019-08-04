# AGCategories
### 一些常用的分类。
对自己以前创建的分类进行总结记录。

### cocoapods 集成
```
platform :ios, '8.0'
target 'AGCategoriesDemo' do

pod 'AGCategories', '~> 0.1.8'

end
```

#### UIImage
- 图片缩放、旋转、拉伸；
- 图片的压缩。转换成字符串；
- 生成二维码图片；
- 根据UIView、UIColor 生成图片；
- 图片边角、圆角裁剪；
- 高斯模糊。

#### NSDate
- 判断是否今天、明天等；
- 获取NSDate中的年、月、日、时、分、秒；
- 毫秒、秒转成 NSDate对象、时间格式化字符串；
- 时间格式化字符串 ==> NSDate对象；
- NSDate对象转化成时间格式字符串；

#### NSBundle
- 加载 Cocoapods 资源的NSBundle 分类；
- 一些快速获取资源包的方法。

#### UIColor
- RGB、RGBA 生成 UIColor对象；
- “OXFFFFFF”或“#FFFFFF” 生成 UIColor对象；
- 随机色。

#### NSString
- 字符长度、范围判断；
- 数字、英文、中文、Emoji表情，字符判断与长度计算；
- 手机号、邮箱、QQ号判断。

#### NSFileManager
- 统计文件夹 Size；
- 删除文件夹；
- 获取沙盒路径。

