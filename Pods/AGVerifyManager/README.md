# AGVerifyManager
### 思路描述
- 参考了 Masonry 的链式语法，链式语法的优雅非常适合用来连续验证多个数据。
- 因为用户需要验证的数据是变化且各不相同的，所以把变化隔离开来，独立封装。
- 验证的时候需要集中处理，所以用代码块统一了起来。

![AGVerifyManagerDemo.png](https://upload-images.jianshu.io/upload_images/331623-b6ccc3d819e984dc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/350)

### cocoapods 集成
```
platform :ios, '7.0'
target 'AGVerifyManagerDemo' do

pod 'AGVerifyManager'

end
```

### 使用说明
```objective-c
- 创建遵守并实现<AGVerifyManagerVerifiable>协议的验证器类；
- 如：Emoji表情验证器、手机号码验证器 ...
- 使用 AGVerifyManager 搭配相应的验证器对数据进行验证和结果回调。
- 
- AGVerifyManager 可以直接执行验证，然后释放Block；
- 也可以保存Block，通过Key个别进行验证，重复进行验证，或者在后台线程进行验证。
- 
- 具体可参考 Demo
- 下面是代码片段
```

#### 通过Key 执行验证
```objective-c
// 1. 判断用户输入文字限制
ATTextLimitVerifier *usernameVerifier = [ATTextLimitVerifier new];
usernameVerifier.minLimit = 2;
usernameVerifier.maxLimit = 7;
usernameVerifier.maxLimitMsg =
[NSString stringWithFormat:@"文字不能超过%@个字符！", @(usernameVerifier.maxLimit)];

// 2. 判断文字是否包含 emoji 😈
ATEmojiVerifier *emojiVerifier = [ATEmojiVerifier new];
emojiVerifier.errorMsg = @"请输入非表情字符！";
    
// 3. 判断文字是否包含空格
ATWhiteSpaceVerifier *whiteSpaceVerifier = [ATWhiteSpaceVerifier new];
    
// 4. 准备验证
__weak typeof(self) weakSelf = self;
[self.verifyManager ag_addVerifyForKey:@"Key" verifying:^(id<AGVerifyManagerVerifying> start) {
        
    __strong typeof(weakSelf) self = weakSelf;
        
    start
    // 用法一：传入验证器和需要验证的数据；
    .verifyData(usernameVerifier, self.nameTextField.text)
    .verifyData(emojiVerifier, self.nameTextField.text)
    // 用法二：传入验证器、数据、提示的内容；
    .verifyDataWithMsg(whiteSpaceVerifier, self.nameTextField.text, @"文字不能包含空格！")
    // 用法三：传入验证器、数据、你想传递的对象；文本框闪烁
    .verifyDataWithContext(self, self.nameTextField.text, self.nameTextField);
        
} completion:^(AGVerifyError *firstError, NSArray<AGVerifyError *> *errors) {
        
    __strong typeof(weakSelf) self = weakSelf;
    if ( firstError ) {
        // 验证不通过
        self.resultLabel.textColor = [UIColor redColor];
        self.resultLabel.text = firstError.msg;
            
        // 文本框闪烁
        [errors enumerateObjectsUsingBlock:^(AGVerifyError *obj, NSUInteger idx, BOOL *stop) {
                
            // 取出传递的对象，根据自身业务处理。
            if ( obj.context == self.nameTextField ) {
                // 取色
                UIColor *color;
                if ( obj.code == 100 ) {
                    color = [UIColor redColor];
                }
                else if ( obj.code == 200 ) {
                    color = [UIColor purpleColor];
                }
                // 动画
                [UIView animateWithDuration:0.15 animations:^{
                    self.nameTextField.backgroundColor = color;
                } completion:^(BOOL finished) {
                    self.nameTextField.backgroundColor = [UIColor whiteColor];
                }];
            }
        }];
    }
    else {
        // TODO
        self.resultLabel.textColor = [UIColor greenColor];
        self.resultLabel.text = @"验证通过！";
        self.nameTextField.backgroundColor = [UIColor whiteColor];
    }
}];

// 5. 执行验证
[self.verifyManager ag_executeVerifyBlockForKey:@"Key"];

```

#### 执行耗时验证
```objective-c
ATBusyVerifier *busy = [ATBusyVerifier new];
self.verifyManager = ag_newAGVerifyManager();
for (int i = 0; i<24; i++) {
    NSString *intStr = [NSNumber numberWithInt:i].stringValue;
    [self.verifyManager ag_addVerifyForKey:intStr verifying:^(id<AGVerifyManagerVerifying> start) {
    
        // 耗时验证
        start
        .verifyData(busy, intStr)
        .verifyData(busy, intStr);
        
    } completion:^(AGVerifyError *firstError, NSArray<AGVerifyError *> *errors) {
    
        NSLog(@"耗时验证完成----------- %@", intStr);
    }
}

/** 多线程执行验证Blocks，verifyingBlock 在其他线程下执行；completionBlock 回到主线程执行。*/
[self.verifyManager ag_executeAllVerifyBlocksInBackground];

```

#### 直接执行验证
```objective-c
- (void) ag_executeVerifying:(NS_NOESCAPE AGVerifyManagerVerifyingBlock)verifyingBlock
                  completion:(NS_NOESCAPE AGVerifyManagerCompletionBlock)completionBlock;

```


