platform :ios, '8.0'
inhibit_all_warnings!

target 'AGThemeManager' do
    pod 'AGViewModel', '~> 0.6'
    pod 'AGCategories', '~> 0.1'
    pod 'AGTimerManager', '~> 0.5'
    pod 'AGVerifyManager', '~> 0.3'
    pod 'SVProgressHUD'
    
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
    end
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
      end
    end
  end
end
