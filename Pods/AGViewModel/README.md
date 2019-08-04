# AGViewModel

### Cocoapods 集成
``` objective-c
platform :ios, '7.0'
target 'AGViewModel' do

pod 'AGViewModel', '~> 0.6.25'

end
```

### 设计思路
在实践 casa 的去Model化后，为了解决网络数据获取后如何处理、如何更新、如何监听模型数据变化等一系列细节问题，而设计了AGViewModel。
其主要作用就是管理视图与数据之间的关系，简化工作，尽量少做重复事情。

#### 持有一个字典数据模型，并弱引用视图【 View <·· AGViewModel -> Model 】
- 用户通过AGViewModel 对字典模型进行数据增删改查。
- 数据改变后，用户可以通过AGViewModel 通知视图更新自己的Size 或刷新UI界面。
- 具体怎样计算Size 和怎样显示UI 由视图自己决定。（当需要这么做的时候，AGViewModel会把数据提供给视图）
- 当视图产生了用户的点击事件时，视图通过AGViewModel 把事件传递给 ViewController 处理。
- 用户对数据的操作和对事件的处理都是在 ViewController 上进行的。（对，不要忘了 ViewController也要干活）
- 大体关系是：
- View-显示UI，接收UI事件；ViewModel-协调视图和控制器干活；Model-🌚；Controller-处理数据和UI事件。

##### AGViewModel 对视图Size 的管理方法。
```objective-c
/** 获取 bindingView 的 size，从缓存中取。如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (CGSize) ag_sizeOfBindingView;

/** 直接传进去计算并返回视图Size，如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (CGSize) ag_sizeForBindingView:(UIView<AGVMIncludable> *)bv;

/** 计算并缓存绑定视图的Size */
- (CGSize) ag_cachedSizeByBindingView:(UIView<AGVMIncludable> *)bv;

/** 对“需要缓存的视图Size”进行标记；当调用获取视图Size的方法时，从视图中取。*/
- (void) ag_setNeedsCachedBindingViewSize;

/** 如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (void) ag_cachedBindingViewSizeIfNeeded;

```
##### AGViewModel 对视图UI 的管理方法。
```objective-c
/** 马上更新数据 并 刷新视图 */
- (void) ag_refreshUIByUpdateModelInBlock:(nullable NS_NOESCAPE AGVMUpdateModelBlock)block;

/** 更新数据，并对“需要刷新UI”进行标记；当调用ag_refreshUIIfNeeded时，刷新UI界面。*/
- (void) ag_setNeedsRefreshUIModelInBlock:(nullable NS_NOESCAPE AGVMUpdateModelBlock)block;

/** 对“需要刷新UI”进行标记；当调用ag_refreshUIIfNeeded时，刷新UI界面。*/
- (void) ag_setNeedsRefreshUI;

/** 刷新UI界面。*/
- (void) ag_refreshUI;

/** 如果有“需要刷新UI”的标记，马上刷新界面。 */
- (void) ag_refreshUIIfNeeded;

```

##### 视图要做的两件事
```objective-c
// 设置模型数据，更新UI
- (void)setViewModel:(AGViewModel *)viewModel
{
	[super setViewModel:viewModel];
	// TODO
  
}

// 计算返回自己的 Size
- (CGSize) ag_viewModel:(AGViewModel *)vm sizeForLayout:(UIScreen *)screen
{
  // size
  
}
```

### 还能能做什么？
#### 把视图的各种用户操作传递给代理处理（一般都是Controller）
- 传递事件
- 参考Demo 中点击书本封面

```objective-c
@protocol AGVMDelegate <NSObject>

/**
 通过 viewModel 的 @selector(ag_makeDelegateHandleAction:)        方法通知 delegate 做事。
 通过 viewModel 的 @selector(ag_makeDelegateHandleAction:info:)   方法通知 delegate 做事。
 */

@optional
- (void) ag_viewModel:(AGViewModel *)vm handleAction:(nullable SEL)action;
- (void) ag_viewModel:(AGViewModel *)vm handleAction:(nullable SEL)action info:(nullable AGViewModel *)info;

@end
```

#### 作为本级控制器与下级控制器之间的桥梁
- 传递数据
- 参考Demo 中删除书本

#### 键值观察 KVO
- 观察内部字典数据的变化
- 传递响应事件
- 参考Demo 中删除书本

#### 数据归档
- 根据你需要提取的keys，把数据归档写入文件

```objective-c
NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.tableViewManager.vmm];
[data writeToURL:[self _archiveURL] atomically:YES];

```

#### Json转换
- 根据你需要提取的keys，拼接成Json字符串（后台说：你直接扔个Json给我，接口写不动了😅）
- 根据Json转成字典和数组（提供了C函数）

```objective-c
    // 取数据
    NSData *data = [NSData dataWithContentsOfURL:[self _archiveURL]];
    AGVMManager *vmm = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // json
    NSString *json = [vmm ag_toJSONString];
    NSError *error;
    NSDictionary *dict = ag_newNSDictionaryWithJSONString(json, &error);
    
```

#### AGVMWeakly 弱引用存取
- 不想强引用对象的时候，可以使用。

```objective-c
/** 添加弱引用的对象 */
- (void)ag_setWeaklyObject:(nullable id)obj forKey:(NSString *)key;

/** 获取弱引用的对象 */
- (nullable id) ag_weaklyObjectForKey:(NSString *)key;

/** 移除弱引用的对象 */
- (void) ag_removeWeaklyObjectForKey:(NSString *)key;
    
```

#### AGVMCommandExecutable 命令编程
- 当需要根据几个变化属性，拿到结果时，可以使用命令编程。

```objective-c
/** 添加命令 */
- (void)ag_setCommand:(AGVMCommand *)command forKey:(NSString *)key;
/** 添加命令Block */
- (void)ag_setCommandBlock:(AGVMCommandExecutableBlock)block forKey:(NSString *)key;
/** 移除命令 */
- (void) ag_removeCommandForKey:(NSString *)key;

/** 获取命令执行结果，直接执行 */
- (nullable id) ag_executeCommandForKey:(NSString *)key;
/** 标记命令待执行 */
- (void) ag_setNeedsExecuteCommandForKey:(NSString *)key;
/** 获取命令执行结果，有标记才执行命令，否则直接从字典中取 */
- (nullable id) ag_executeCommandIfNeededForKey:(NSString *)key;
    
```

#### AGVMMethodChaining 链式方法
- 支持一些方便的链式方法调用

#### 对id类型数据判断处理
- 对API返回数据的边界判断和处理
- 参考 AGVMSafeAccessible 协议

### 类之间的关系
#### AGViewModel 与 AGVMPackagable协议 的关系
- 遵守AGVMPackagable协议的类（简称VMP），提供了对API数据的处理，并生成 AGViewModel。
- 一个视图是可以显示多个API数据的，例如一个参与抽奖的用户和参与投票的用户，获取数据的API不同，但显示效果是一致的。
- 那么VMP就是为视图服务的，把各种各样的API数据处理成视图可以接受的数据。（视图就是通过setViewModel:来更新UI界面的）
- 当一个界面需要显示各种Cell的时候，只要把API数据经过不同的VMP过滤就可以取出具备显示条件的数据了。
- Cell 的复用很简单：
- 调用类方法+ag_dequeueCellBy:for: 获取
- 当然前提是要在前面注册+ag_registerCellBy:

##### AGVMPackagable协议

``` objective-c
@protocol AGVMPackagable <NSObject>
- (AGViewModel *) ag_packageData:(NSDictionary *)dict forObject:(nullable id)obj;
@end
```

#### 视图复用的一些协议已经在分类中实现（有特殊需求 Override）
``` objective-c
@interface UITableView (AGViewModel)

#pragma mark - table view cell
- (void) ag_registerCellForClass:(Class<AGViewReusable>)cls;
- (void) ag_registerNibCellForClass:(Class<AGViewReusable>)cls;
- (__kindof UITableViewCell *) ag_dequeueCellWithClass:(Class<AGViewReusable>)cls for:(nullable NSIndexPath *)indexPath;


#pragma mark - table view header footer view
- (void) ag_registerHeaderFooterViewForClass:(Class<AGViewReusable>)cls;
- (void) ag_registerNibHeaderFooterViewForClass:(Class<AGViewReusable>)cls;
- (__kindof UITableViewHeaderFooterView *) ag_dequeueHeaderFooterViewWithClass:(Class<AGViewReusable>)cls;

@end


@interface UICollectionView (AGViewModel)

#pragma mark collection view cell
- (void) ag_registerCellForClass:(Class<AGViewReusable>)cls;
- (void) ag_registerNibCellForClass:(Class<AGViewReusable>)cls;
- (__kindof UICollectionViewCell *) ag_dequeueCellWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath;


#pragma mark collection view footer view
- (void) ag_registerFooterViewForClass:(Class<AGViewReusable>)cls;
- (void) ag_registerNibFooterViewForClass:(Class<AGViewReusable>)cls;
- (__kindof UICollectionReusableView *) ag_dequeueFooterViewWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath;


#pragma mark collection view header view
- (void) ag_registerHeaderViewForClass:(Class<AGViewReusable>)cls;
- (void) ag_registerNibHeaderViewForClass:(Class<AGViewReusable>)cls;
- (__kindof UICollectionReusableView *) ag_dequeueHeaderViewWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath;

@end

```

```objective-c
#pragma mark - ------------- ViewModel 相关协议 --------------
#pragma mark BaseReusable Protocol
@protocol AGBaseReusable <NSObject>
@required
+ (NSString *) ag_reuseIdentifier;

@optional
/** 如果使用默认 nib、xib 创建视图，又需要打包成库文件的时候，请返回你的资源文件目录。*/
+ (NSBundle *) ag_resourceBundle;
@end

#pragma mark CollectionViewCell Protocol
@protocol AGCollectionCellReusable <AGBaseReusable>
@required
+ (void) ag_registerCellBy:(UICollectionView *)collectionView;
+ (__kindof UICollectionViewCell *) ag_dequeueCellBy:(UICollectionView *)collectionView
                                                 for:(nullable NSIndexPath *)indexPath;
@end

#pragma mark HeaderViewReusable Protocol
@protocol AGCollectionHeaderViewReusable <AGBaseReusable>
@required
+ (void) ag_registerHeaderViewBy:(UICollectionView *)collectionView;
+ (__kindof UICollectionReusableView *) ag_dequeueHeaderViewBy:(UICollectionView *)collectionView
                                                           for:(nullable NSIndexPath *)indexPath;
@end

#pragma mark FooterViewReusable Protocol
@protocol AGCollectionFooterViewReusable <AGBaseReusable>
@required
+ (void) ag_registerFooterViewBy:(UICollectionView *)collectionView;
+ (__kindof UICollectionReusableView *) ag_dequeueFooterViewBy:(UICollectionView *)collectionView
                                                           for:(nullable NSIndexPath *)indexPath;
@end

#pragma mark TableViewCell Protocol
@protocol AGTableCellReusable <AGBaseReusable>
@required
+ (void) ag_registerCellBy:(UITableView *)tableView;
+ (__kindof UITableViewCell *) ag_dequeueCellBy:(UITableView *)tableView
                                            for:(nullable NSIndexPath *)indexPath;
@end

#pragma mark HeaderFooterViewReusable Protocol
@protocol AGTableHeaderFooterViewReusable <AGBaseReusable>
@required
+ (void) ag_registerHeaderFooterViewBy:(UITableView *)tableView;
+ (__kindof UITableViewHeaderFooterView *) ag_dequeueHeaderFooterViewBy:(UITableView *)tableView;

@end

```

#### AGViewModel 与 AGVMSection、AGVMManager 的关系
- 简单来说就是 AGVMSection 管理一组 AGViewModel，AGVMManager 管理多组 AGViewModel（就是管理多个AGVMSection）。
- 从视图层面说，就是：
- AGViewModel 能够管理 TableViewCell 的数据。
- AGVMSection 能够管理 一组TableViewCell 和 HeaderView、FooterView 的数据。
- AGVMManager 能够管理 整个TableView 的数据；

#### AGVMNotifier 与 AGViewModel 的关系
- 当用户需要监听 AGViewModel 的通用字典数据变化时，后台操作就是由 AGVMNotifier 提供的。
-AGVMNotifier 是通过KVO 来处理监听事件的。AGVMNotifier 同时也处理了KVO的崩溃问题。

#### AGVMSharedPackager 与 AGViewModel 的关系
- AGVMSharedPackager 就是方便打包AGViewModel 数据的单例。
- AGVMSharedPackager 可以对数据进行打印，打印出需要的代码。

##### 打印需要的代码
```objective-c
/**
 分解打印 JSON 为常量。（嵌套支持）
 
 @param object 待分解的字典或数组
 @param moduleName 模块的名称
 */
- (void) ag_resolveStaticKeyFromObject:(id)object
                            moduleName:(NSString *)moduleName;
```

### Debug 查看内部数据结构
<img src="https://raw.githubusercontent.com/JohnnyB0Y/AGViewModel/master/AGViewModelDemo/Assets.xcassets/WX20180509-131537.imageset/WX20180509-131537%402x.png" width = "516" height = "100" />

<img src="https://raw.githubusercontent.com/JohnnyB0Y/AGViewModel/master/AGViewModelDemo/Assets.xcassets/WX20180509-131441.imageset/WX20180509-131441%402x.png" width = "516" height = "555" />


