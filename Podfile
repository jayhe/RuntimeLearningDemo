# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'RuntimeLearning' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  pod 'Aspects', '~> 1.4.1'
  pod 'fishhook', '~> 0.2'
  pod 'HCClangTrace', :git => 'https://github.com/jayhe/HCClangTrace.git'
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
      macho_type = config.build_settings['MACH_O_TYPE']
      #if macho_type == 'staticlib'
        # 将依赖的pod项目的Other C Flags加上’-fsanitize-coverage=func,trace-pc-guard‘选项
        config.build_settings['OTHER_CFLAGS'] ||= ['$(inherited)', '-fsanitize-coverage=func,trace-pc-guard']
        config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['$(inherited)', '-fsanitize-coverage=func,trace-pc-guard']
      #end
    end
  end
end
