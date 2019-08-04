
#
#  Be sure to run `pod spec lint AGThemeManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "AGThemeManager" # 项目名称
  s.version      = "0.0.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = "MIT"          # 开源证书
  s.summary      = "主题包管理，动态更新全局主题元素。" # 项目简介

  s.homepage     = "https://github.com/JohnnyB0Y/AGThemeManager" # 你的主页
  s.source       = { :git => "https://github.com/JohnnyB0Y/AGThemeManager.git", :tag => "#{s.version}" }# 你的仓库地址，不能用SSH地址
  s.source_files = "AGThemeManager/Core/**/*.{h,m}" # 你代码的位置， AGThemeManager/*.{h,m} 表示 AGThemeManager 文件夹下所有的.h和.m文件
  s.requires_arc = true # 是否启用ARC

  s.platform     = :ios, "7.0" # 平台及支持的最低版本
  # s.ios.deployment_target = '7.0'
  # s.osx.deployment_target = '10.8'
  # s.watchos.deployment_target = '2.0'
  # s.tvos.deployment_target = '9.0'

  s.frameworks   = "Foundation" # 支持的框架
  # s.dependency   = "AFNetworking" # 依赖库
  
  # User
  s.author             = { "JohnnyB0Y" => "ag860050872@163.com" } # 作者信息
  s.social_media_url   = "https://johnnyb0y.github.io/" # 个人主页

end
