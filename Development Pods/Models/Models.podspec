Pod::Spec.new do |spec|

  spec.name         = "Models"
  spec.version      = "0.0.1"
  spec.summary      = "Generic data models for Apron."
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

  spec.dependency 'Decoders'
  spec.dependency 'DesignSystem'

end
