# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

workspace 'Apron'

def commonPods
  # Pods for Apron

  pod 'PanModal', :inhibit_warnings => true
  pod 'Kingfisher', '~> 7.0'
  pod 'UIScrollView-InfiniteScroll', :inhibit_warnings => true
  pod 'ALProgressView', :inhibit_warnings => true
  pod 'IQKeyboardManagerSwift'

  # Dev Tools

  pod 'SwiftGen', '~> 6.0'

  #Analytics & User interaction

  pod 'Amplitude', :inhibit_warnings => true
  pod 'Firebase/Analytics', :inhibit_warnings => true
  pod 'Firebase/Crashlytics', :inhibit_warnings => true
  pod 'Firebase/RemoteConfig', :inhibit_warnings => true
  pod 'Firebase/DynamicLinks', :inhibit_warnings => true
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0', :inhibit_warnings => true
  pod 'Mixpanel-swift', :inhibit_warnings => true
  pod 'Sentry'

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

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
    end
  end
end

