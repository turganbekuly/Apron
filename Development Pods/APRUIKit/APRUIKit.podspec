Pod::Spec.new do |spec|

  spec.name         = "APRUIKit"
  spec.version      = "0.0.1"
  spec.summary      = "UIKit для Apron.kz"

  spec.description  = <<-DESC
    0.0.1 Первая версия
  DESC

  spec.homepage     = "https://apron.ws"

  spec.license      = "MIT (example)"
  spec.license      = {
    :type => 'Custom',
    :text => <<-LICENSE
    Copyright 2021
    Permission is granted to Apron.ws
    LICENSE
  }

  spec.author             = { "Akarys Turganbekuly" => "support@apron.ws" }
  spec.platform     = :ios, "13.0"

  spec.source       = { 
    :git => "https://github.com/turganbekuly/Apron.git", 
    :tag => "#{spec.version}" 
  }

  spec.source_files  = ["**/*.{h,m,swift}"]

  spec.resources =  [
    'APRUIKit/**/*.{ttf}'
  ]
  spec.resource_bundles = {
      'APRUIKit' => [
          'APRUIKit/**/*.{xcassets,ttf,strings,lproj}'
      ]
  }
  spec.dependency "AlignedCollectionViewFlowLayout"
  spec.dependency 'Extensions'
  spec.dependency 'Protocols'
  spec.dependency 'SnapKit'
  spec.dependency 'M13Checkbox'
  spec.dependency 'NVActivityIndicatorView'

end
