Pod::Spec.new do |spec|

  spec.name         = "DesignSystem"
  spec.version      = "0.0.1"
  spec.summary      = "DesignSystem for Apron."
  
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
  'DesignSystem/**/*.{ttf}'
  ]
  spec.resource_bundles = {
    'DesignSystem' => [
    'DesignSystem/**/*.{xcassets,ttf,otf,strings,lproj,xib}'
    ]
  }
  spec.dependency 'AlignedCollectionViewFlowLayout', '1.1.2'
  spec.dependency 'Extensions'
  spec.dependency 'Protocols'
  spec.dependency 'SnapKit', '5.0.1'
  spec.dependency 'M13Checkbox'

end
