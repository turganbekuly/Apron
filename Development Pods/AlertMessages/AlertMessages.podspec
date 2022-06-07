Pod::Spec.new do |spec|

  spec.name         = "AlertMessages"
  spec.version      = "0.0.1"
  spec.summary      = "Alert Messages for Apron."
  spec.homepage     = "https://apron.com"
  spec.license      = { :type => 'Custom', :text => <<-LICENSE
     Copyright 2022
     Permission is granted to Apron.com
     LICENSE
   }
  spec.author             = { "Akarys Turganbekuly" => "akarysid@gmail.com" }
 
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/AlmostDeveloper/Apron.git", :tag => "#{spec.version}" }

  spec.source_files  = ["**/*.{h,m,swift}"]

  spec.resources =  [
  'DesignSystem/**/*.{json}'
  ]
  spec.resource_bundles = { 'AlertMessages-Assets' => ['AlertMessages/**/*.{xcassets,json}'] }

  spec.dependency 'HapticTouch'
  spec.dependency 'Protocols'
  spec.dependency 'DesignSystem'
  spec.dependency 'SwiftEntryKit'
  spec.dependency 'lottie-ios'

end
