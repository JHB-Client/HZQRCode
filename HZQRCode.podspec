Pod::Spec.new do |s|
  s.name         = "HZQRCode"
  s.version      = "0.0.1"
  s.summary      = "原生二维码的封装"

  s.description  = <<-DESC
                      对原生二维码的封装
                   DESC

  s.homepage     = "https://github.com/jihuaibin2015/HZQRCode"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "jihuaibin2015" => "15158863897@163.com" }


  s.platform     = :ios

  s.source       = { :git => "https://github.com/jihuaibin2015/HZQRCode.git", :tag => "0.0.1" }
  s.source_files  = "HZQRCode/**/*.{h,m}"
  s.requires_arc = true
end
