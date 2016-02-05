#WKTextFieldFormatter.podspec
Pod::Spec.new do |s|
  s.name         = "WKTextFieldFormatter"
  s.version      = "1.1"
  s.summary      = "Easily block the unwanted input to the textField."
  s.homepage     = "https://github.com/WelkinXie/WKTextFieldFormatter"
  s.license      = 'MIT'
  s.author       = { "Welkin Xie" => "welkin995@126.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/WelkinXie/WKTextFieldFormatter.git", :tag => s.version}
  s.source_files  = 'WKTextFieldFormatter/WKTextFieldFormatter/*.{h,m}'
  s.requires_arc = true
end