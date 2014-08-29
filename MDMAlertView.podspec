Pod::Spec.new do |s|
  s.name         = "MDMAlertView"
  s.version      = "0.0.1"
  s.summary      = "Custom blured Alert"
  s.description  = "Custom blured Alert and buttons blured Alert"
  s.homepage     = "https://github.com/alekoleg/MDMAlertView.git"
  s.license      = 'MIT'
  s.author       = { "Oleg Alekseenko" => "alekoleg@gmail.com" }
  s.source       = { :git => "https://github.com/alekoleg/MDMAlertView.git", :tag => s.version.to_s}
  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  s.public_header_files = 'Classes/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'QuartzCore', 'CoreGraphics'
  s.dependency 'FXBlurView'

end
