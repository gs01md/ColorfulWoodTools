

Pod::Spec.new do |s|

  s.name         = "ColorfulWoodTools"
  s.version      = "1.0.3"
  s.summary      = "tools for ios."

  s.homepage     = "https://github.com/gs01md"

  s.license      = "MIT"

  s.author       = { "ColorfulWood" => "103377808@qq.com" }

  s.source       = { :git => "https://github.com/gs01md/ColorfulWoodTools.git", :tag => "#{s.version}" }

  s.source_files = "ColorfulWoodTools/ColorfulWoodTools/**/*"

  s.platform     = :ios, "8.0"

  s.frameworks   = 'Foundation'
  s.frameworks   = 'UIKit'

  s.dependency   'MBProgressHUD', '~> 0.9.1'

end
