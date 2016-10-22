#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJLinksButton"
  s.version          = "0.0.1"
  s.summary          = "带下划线的button"
  s.description      = <<-DESC
                      比如注册协议，往往下面有一条横线。也是HTML种a标签的默认效果
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  s.screenshots      = "http://120.27.93.73/files/myPublicProject/YXJLinksButton1.png"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/YXJLinksButton.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJLinksButton"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJLinksButton"

  s.source_files = 'Pod/*'
  #s.public_header_files = 'Pod/*'
  #s.resource = 'pod/*.bundle'

  s.frameworks = 'UIKit'

end

