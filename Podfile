# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'TruckYums' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'GoogleUtilities'
  pod 'IGListKit', '~> 4.0.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Core' 
  pod 'Firebase/Firestore'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'SnapKit'
  pod 'Google-Mobile-Ads-SDK', '~> 9.14.0'
  pod 'RestKit'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        # Force CocoaPods targets to always build for x86_64
        config.build_settings['ARCHS[sdk=iphonesimulator*]'] = 'x86_64'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
  # Pods for TruckYums

  target 'TruckYumsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TruckYumsUITests' do
    # Pods for testing
  end

end
