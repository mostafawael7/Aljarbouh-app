# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'Aljarbouh' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Networking
pod 'Alamofire'
pod 'SwiftyJSON', '~> 4.0'
pod 'Kingfisher', '~> 7.0'
pod 'SVGKit'
  
  # Pods for Aljarbouh
pod 'FluidTabBarController'
pod 'HidingNavigationBar', '~> 1.0'
pod 'HorizontalCalendar'
pod 'IQKeyboardManagerSwift'
pod 'DropDown'

end

post_install do |installer|
  # fix xcode 15 DT_TOOLCHAIN_DIR - remove after fix oficially - https://github.com/CocoaPods/CocoaPods/issues/12065
  installer.aggregate_targets.each do |target|
    target.xcconfigs.each do |variant, xcconfig|
      
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
    end
  end
  
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
        xcconfig_path = config.base_configuration_reference.real_path
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
  end
end
