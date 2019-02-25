# Uncomment the next line to define a global platform for your project
platform :ios, '9.1'
inhibit_all_warnings!
target 'Manager' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
  pod 'Router_t', '~>0.0.6'
  pod 'AFNetworking'
  pod 'Masonry'
  pod 'QMUIKit'
  pod 'IQKeyboardManager'
  pod 'ChameleonFramework'
  pod 'ReactiveCocoa', '2.5'
  pod 'LKDBHelper'
  pod 'JPush'
  pod 'YYModel'
  pod 'Xor_t'
  # Pods for Manager

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
 target.build_configurations.each do |config|
  if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
     end
   end
  end
end
