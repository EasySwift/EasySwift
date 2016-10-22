#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJSlideBar"
  s.version          = "0.0.1"
  s.summary          = "极其方便的画出真正的一个像素的线"
  s.description      = <<-DESC
                      极其方便的画出真正的一个像素的线
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  s.screenshots      = "http://120.27.93.73/files/myPublicProject/YXJSlideBar1.gif"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/EasySwift/YXJSlideBar.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJSlideBar"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJSlideBar"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  #s.resource = 'pod/*.bundle'
  
  s.frameworks = 'UIKit'

end

