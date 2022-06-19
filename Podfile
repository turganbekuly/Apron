# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Apron'

def commonPods
  # Pods for Apron

  pod 'PanModal'
  pod 'Kingfisher'
  pod 'UIScrollView-InfiniteScroll'

  # Dev Tools

  pod 'SwiftGen', '~> 6.0'

  #Analytics & User interaction

  pod 'Amplitude'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/RemoteConfig'
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
end

def developmentPods
  pod 'Protocols', path: './Development Pods/Protocols'
  pod 'Onboarding', path: './Development Pods/Onboarding'
  pod 'APRUIKit', path: './Development Pods/APRUIKit'
  pod 'Extensions', path: './Development Pods/Extensions'
  pod 'Configurations', path: './Development Pods/Configurations'
  pod 'Storages', path: './Development Pods/Storages'
  pod 'Decoders', path: './Development Pods/Decoders'
  pod 'Models', path: './Development Pods/Models'
  pod 'HapticTouch', path: './Development Pods/HapticTouch'
  pod 'AKNetwork', path: './Development Pods/AKNetwork'
  pod 'AlertMessages', path: './Development pods/AlertMessages'
  pod 'FeatureToggle', path: './Development pods/FeatureToggle'
  pod 'RemoteConfig', path: './Development pods/RemoteConfig'
end


target 'Apron' do
  commonPods
  developmentPods
end

target 'OneSignalNotificationServiceExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
    end
  end
end

