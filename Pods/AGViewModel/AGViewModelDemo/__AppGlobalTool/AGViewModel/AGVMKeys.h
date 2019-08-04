//
//  AGVMKeys_h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  viewModel const keys

#import <Foundation/Foundation.h>
#ifndef AGVMKeys_h
#define AGVMKeys_h


#pragma mark - Define
/** TODO 宏 */
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO~" DEFER_STRINGIFY(__COUNTER__) "] " MSG " [LINE:" DEFER_STRINGIFY(__LINE__) "]"
#define AGTODO(MSG) PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))

/** min < idx < max; return BOOL. */
#define AGIsIndexInRange(min, idx, max) ((min) < (idx)) && ((idx) < (max))

#define AGAssertIndexRange(min, idx, max) NSAssert(AGIsIndexInRange((min), (idx), (max)), @"Index out of range.")

#define AGAssertParameter(parameter) NSParameterAssert((parameter))


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
// view model const key
//
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#pragma mark - 携带数据相关
FOUNDATION_EXTERN NSString * const kAGVMObject;         ///< 携带的对象 👉id👈
FOUNDATION_EXTERN NSString * const kAGVMArray;          ///< 携带的数组 👉NSArray👈
FOUNDATION_EXTERN NSString * const kAGVMTextArray;      ///< 携带的字符串数组 👉NSArray<NSString>👈
FOUNDATION_EXTERN NSString * const kAGVMAttrTextArray;  ///< 携带的富文本字符串数组 👉NSArray<NSAttributedString>👈
FOUNDATION_EXTERN NSString * const kAGVMNumberArray;    ///< 携带的数字数组 👉NSArray<NSNumber>👈
FOUNDATION_EXTERN NSString * const kAGVMDictionary;     ///< 携带的字典 👉NSDictionary👈
FOUNDATION_EXTERN NSString * const kAGViewModel;        ///< 携带的AGViewModel 👉AGViewModel👈
FOUNDATION_EXTERN NSString * const kAGVMSection;        ///< 携带的AGVMSection 👉AGVMSection👈
FOUNDATION_EXTERN NSString * const kAGVMManager;        ///< 携带的AGVMManager 👉AGVMManager👈
FOUNDATION_EXTERN NSString * const kAGVMCommonVM;       ///< 携带的公共VM 👉AGViewModel👈
FOUNDATION_EXTERN NSString * const kAGVMHeaderVM;       ///< 携带的头部VM 👉AGViewModel👈
FOUNDATION_EXTERN NSString * const kAGVMFooterVM;       ///< 携带的尾部VM 👉AGViewModel👈


#pragma mark - 状态描述相关
FOUNDATION_EXTERN NSString * const kAGVMSelected;   ///< 是否选中？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMDisabled;   ///< 是否禁用？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMDeleted;    ///< 是否删除？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMReloaded;   ///< 是否刷新？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMAdded;      ///< 是否添加？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMShowed;     ///< 是否显示？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMOpened;     ///< 是否打开？ 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMClosed;     ///< 是否关闭？ 👉NSNumber👈


#pragma mark - Block 的存取相关
FOUNDATION_EXTERN NSString * const kAGVMTargetVCClass;  ///< 目标跳转控制器 - 类对象      👉Class👈
FOUNDATION_EXTERN NSString * const kAGVMTargetVCTitle;  ///< 目标跳转控制器 - 标题       👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMTargetVCType;   ///< 目标跳转控制器 - 类型       👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMTargetVCBlock;  ///< 目标跳转控制器 - 执行的代码块 👉Block👈


#pragma mark - 显示的视图相关
FOUNDATION_EXTERN NSString * const kAGVMViewClass;      ///< view 类对象 👉Class👈
FOUNDATION_EXTERN NSString * const kAGVMView;           ///< view 对象 👉UIView👈
FOUNDATION_EXTERN NSString * const kAGVMViewHidden;     ///< view 隐藏 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMViewClassName;  ///< view 类名字符串 👉NSString👈


#pragma mark 类型or标记
FOUNDATION_EXTERN NSString * const kAGVMViewTag;        ///< view 标记 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMIndexPath;      ///< 位置信息 👉NSIndexPath👈
FOUNDATION_EXTERN NSString * const kAGVMType;           ///< View Model 的类型 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMIndex;          ///< 位置信息  👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMCapacity;       ///< 容量标记  👉NSNumber👈


#pragma mark 尺寸
FOUNDATION_EXTERN NSString * const kAGVMViewH;              ///< 视图高度 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMViewW;              ///< 视图宽度 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMViewAspectRatio;    ///< 宽高比 👉NSNumber👈
FOUNDATION_EXTERN NSString * const kAGVMViewEdgeInsets;     ///< 视图内边距 UIEdgeInsets 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMViewEdgeMargin;     ///< 视图外边距 UIEdgeInsets 👉NSString👈


#pragma mark 颜色
FOUNDATION_EXTERN NSString * const kAGVMViewBGColor;        ///< view 背景色 👉UIColor👈
FOUNDATION_EXTERN NSString * const kAGVMViewDisplayType;    ///< view 显示类型 👉NSNumber👈


#pragma mark 元素
FOUNDATION_EXTERN NSString * const kAGVMTitleText;              ///< 标题内容 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMTitlePlaceholder;       ///< 标题占位符 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMTitleAttrText;          ///< 富文本标题 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMTitleAttrPlaceholder;   ///< 富文本标题占位符 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMTitleColor;             ///< 标题颜色 👉UIColor👈
FOUNDATION_EXTERN NSString * const kAGVMTitleFont;              ///< 标题字体大小 👉UIFont👈


FOUNDATION_EXTERN NSString * const kAGVMSubTitleText;           ///< 子标题内容 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMSubTitlePlaceholder;    ///< 子标题占位符 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMSubTitleAttrText;       ///< 富文本子标题 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMSubTitleAttrPlaceholder;///< 富文本子标题占位符 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMSubTitleColor;          ///< 子标题颜色 👉UIColor👈
FOUNDATION_EXTERN NSString * const kAGVMSubTitleFont;           ///< 子标题字体大小 👉UIFont👈


FOUNDATION_EXTERN NSString * const kAGVMDetailText;             ///< 详情内容 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMDetailPlaceholder;      ///< 详情内容占位符 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMDetailAttrText;         ///< 富文本详情内容 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMDetailAttrPlaceholder;  ///< 富文本详情内容占位符 👉NSAttributedString👈
FOUNDATION_EXTERN NSString * const kAGVMDetailColor;            ///< 详情颜色 👉UIColor👈
FOUNDATION_EXTERN NSString * const kAGVMDetailFont;             ///< 详情字体大小 👉UIFont👈


FOUNDATION_EXTERN NSString * const kAGVMImage;              ///< 图片 👉UIImage👈
FOUNDATION_EXTERN NSString * const kAGVMPlaceholderImage;   ///< 占位图片 👉UIImage👈
FOUNDATION_EXTERN NSString * const kAGVMThumbnailImage;     ///< 缩略图 👉UIImage👈


FOUNDATION_EXTERN NSString * const kAGVMImageURLText;       ///< 网络图片 👉NSString👈
FOUNDATION_EXTERN NSString * const kAGVMImageURL;           ///< 网络图片 👉NSURL👈
FOUNDATION_EXTERN NSString * const kAGVMImageURLPlaceholder;///< 占位网络图片 👉NSString👈

#endif /* AGVMKeys_h */
