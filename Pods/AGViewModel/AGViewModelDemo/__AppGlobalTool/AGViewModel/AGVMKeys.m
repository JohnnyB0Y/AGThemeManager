#import <Foundation/Foundation.h>



#pragma mark - 携带数据相关
NSString * const kAGVMObject = @"kAGVMObject"; ///< 携带的对象 👉id👈
NSString * const kAGVMArray = @"kAGVMArray"; ///< 携带的数组 👉NSArray👈
NSString * const kAGVMTextArray = @"kAGVMTextArray"; ///< 携带的字符串数组 👉NSArray<NSString>👈
NSString * const kAGVMAttrTextArray = @"kAGVMAttrTextArray"; ///< 携带的富文本字符串数组 👉NSArray<NSAttributedString>👈
NSString * const kAGVMNumberArray = @"kAGVMNumberArray"; ///< 携带的数字数组 👉NSArray<NSNumber>👈
NSString * const kAGVMDictionary = @"kAGVMDictionary"; ///< 携带的字典 👉NSDictionary👈
NSString * const kAGViewModel = @"kAGViewModel"; ///< 携带的AGViewModel 👉AGViewModel👈
NSString * const kAGVMSection = @"kAGVMSection"; ///< 携带的AGVMSection 👉AGVMSection👈
NSString * const kAGVMManager = @"kAGVMManager"; ///< 携带的AGVMManager 👉AGVMManager👈
NSString * const kAGVMCommonVM = @"kAGVMCommonVM"; ///< 携带的公共VM 👉AGViewModel👈
NSString * const kAGVMHeaderVM = @"kAGVMHeaderVM"; ///< 携带的头部VM 👉AGViewModel👈
NSString * const kAGVMFooterVM = @"kAGVMFooterVM"; ///< 携带的尾部VM 👉AGViewModel👈


#pragma mark - 类型、状态描述相关
NSString * const kAGVMSelected = @"kAGVMSelected"; ///< 是否选中？ 👉NSNumber👈
NSString * const kAGVMDisabled = @"kAGVMDisabled"; ///< 是否禁用？ 👉NSNumber👈
NSString * const kAGVMDeleted = @"kAGVMDeleted"; ///< 是否删除？ 👉NSNumber👈
NSString * const kAGVMReloaded = @"kAGVMReloaded"; ///< 是否刷新？ 👉NSNumber👈
NSString * const kAGVMAdded = @"kAGVMAdded"; ///< 是否添加？ 👉NSNumber👈
NSString * const kAGVMShowed = @"kAGVMShowed"; ///< 是否显示？ 👉NSNumber👈
NSString * const kAGVMOpened = @"kAGVMOpened"; ///< 是否打开？ 👉NSNumber👈
NSString * const kAGVMClosed = @"kAGVMClosed"; ///< 是否关闭？ 👉NSNumber👈


#pragma mark - Block 的存取相关
NSString * const kAGVMTargetVCClass = @"kAGVMTargetVCClass"; ///< 目标跳转控制器 - 👉Class👈
NSString * const kAGVMTargetVCTitle = @"kAGVMTargetVCTitle"; ///< 目标跳转控制器 - 标题 👉NSString👈
NSString * const kAGVMTargetVCType = @"kAGVMTargetVCType"; ///< 目标跳转控制器 - 类型 👉NSString👈
NSString * const kAGVMTargetVCBlock = @"kAGVMTargetVCBlock"; ///< 目标跳转控制器 - 执行的代码块 👉Block👈


#pragma mark - 显示的视图相关
NSString * const kAGVMViewClass = @"kAGVMViewClass"; ///< view 类对象 👉Class👈
NSString * const kAGVMView = @"kAGVMView"; ///< view 对象 👉UIView👈
NSString * const kAGVMViewHidden = @"kAGVMViewHidden"; ///< hidden 隐藏 👉NSNumber👈
NSString * const kAGVMViewClassName = @"kAGVMViewClassName"; ///< view 类名字符串 👉NSString👈


#pragma mark 标记
NSString * const kAGVMViewTag = @"kAGVMViewTag"; ///< view 标记 👉NSNumber👈
NSString * const kAGVMIndexPath = @"kAGVMIndexPath"; ///< 位置标记 👉NSIndexPath👈
NSString * const kAGVMType = @"kAGVMType"; ///< View Model 的类型 👉NSString👈
NSString * const kAGVMIndex = @"kAGVMIndex"; ///< 位置信息 👉NSNumber👈
NSString * const kAGVMCapacity = @"kAGVMCapacity"; ///< 容量 👉NSNumber👈


#pragma mark 尺寸
/** 视图高度 👉NSNumber👈 */
NSString * const kAGVMViewH = @"kAGVMViewH";

/** 视图宽度 👉NSNumber👈 */
NSString * const kAGVMViewW = @"kAGVMViewW";

/** 宽高比 👉NSNumber👈 */
NSString * const kAGVMViewAspectRatio = @"kAGVMViewAspectRatio";

/** 视图内边距 UIEdgeInsets 👉NSString👈 */
NSString * const kAGVMViewEdgeInsets = @"kAGVMViewEdgeInsets";

/** 视图外边距 UIEdgeInsets 👉NSString👈 */
NSString * const kAGVMViewEdgeMargin = @"kAGVMViewEdgeMargin";


#pragma mark 颜色
/** view 背景色 👉UIColor👈 */
NSString * const kAGVMViewBGColor = @"kAGVMViewBGColor";
/** view 显示类型 👉NSNumber👈 */
NSString * const kAGVMViewDisplayType = @"kAGVMViewDisplayType";


#pragma mark 元素
/** 标题内容 👉NSString👈 */
NSString * const kAGVMTitleText = @"kAGVMTitleText";
NSString * const kAGVMTitlePlaceholder = @"kAGVMTitlePlaceholder";
NSString * const kAGVMTitleAttrText = @"kAGVMTitleAttrText"; ///< 富文本标题 👉NSAttributedString👈
NSString * const kAGVMTitleAttrPlaceholder = @"kAGVMTitleAttrPlaceholder"; ///< 富文本标题占位符 👉NSAttributedString👈
NSString * const kAGVMTitleColor = @"kAGVMTitleColor";
NSString * const kAGVMTitleFont = @"kAGVMTitleFont";


NSString * const kAGVMSubTitleText = @"kAGVMSubTitleText";
NSString * const kAGVMSubTitlePlaceholder = @"kAGVMSubTitlePlaceholder";
NSString * const kAGVMSubTitleAttrText = @"kAGVMSubTitleAttrText"; ///< 富文本子标题 👉NSAttributedString👈
NSString * const kAGVMSubTitleAttrPlaceholder = @"kAGVMSubTitleAttrPlaceholder"; ///< 富文本子标题占位符 👉NSAttributedString👈
NSString * const kAGVMSubTitleColor = @"kAGVMSubTitleColor";
NSString * const kAGVMSubTitleFont = @"kAGVMSubTitleFont";


NSString * const kAGVMDetailText = @"kAGVMDetailText";
NSString * const kAGVMDetailPlaceholder = @"kAGVMDetailPlaceholder";
NSString * const kAGVMDetailAttrText = @"kAGVMDetailAttrText"; ///< 富文本详情内容 👉NSAttributedString👈
NSString * const kAGVMDetailAttrPlaceholder = @"kAGVMDetailAttrPlaceholder"; ///< 富文本详情内容占位符 👉NSAttributedString👈
NSString * const kAGVMDetailColor = @"kAGVMDetailColor";
NSString * const kAGVMDetailFont = @"kAGVMDetailFont";


NSString * const kAGVMImage = @"kAGVMImage"; ///< 图片 👉UIImage👈
NSString * const kAGVMPlaceholderImage = @"kAGVMPlaceholderImage"; ///< 占位图片 👉UIImage👈
NSString * const kAGVMThumbnailImage = @"kAGVMThumbnailImage"; ///< 缩略图 👉UIImage👈


NSString * const kAGVMImageURLText = @"kAGVMImageURLText"; ///< 网络图片 👉NSString👈
NSString * const kAGVMImageURL = @"kAGVMImageURL"; ///< 网络图片 👉NSURL👈
NSString * const kAGVMImageURLPlaceholder = @"kAGVMImageURLPlaceholder"; ///< 占位网络图片 👉NSString👈
