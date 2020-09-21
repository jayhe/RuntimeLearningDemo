# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
target 'RuntimeLearning' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  pod 'Aspects', '~> 1.4.1'
  pod 'fishhook', '~> 0.2'
  pod 'HCClangTrace', :git => 'https://github.com/jayhe/HCClangTrace.git'
  pod 'BlockHook'
  pod 'libffi-iOS', :git => 'https://github.com/sunnyxx/libffi-iOS.git'
  # Pods for RuntimeLearning
  # pod 'xxx', :podspec => 'path'
  target 'RuntimeLearningTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      deployment_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      if deployment_target.to_f < 9.0 #转成float进行比较；发现直接比较字符串 < '10.0'没效果
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
      macho_type = config.build_settings['MACH_O_TYPE']
      #if macho_type == 'staticlib'
        if config.name == 'Debug'
          # 将依赖的pod项目的Other C Flags加上’-fsanitize-coverage=func,trace-pc-guard‘选项
          config.build_settings['OTHER_CFLAGS'] ||= ['$(inherited)', '-fsanitize-coverage=func,trace-pc-guard']
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['$(inherited)', '-fsanitize-coverage=func,trace-pc-guard']
        end
      #end
    end
  end
end
