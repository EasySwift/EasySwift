#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJImageCompressor"
  s.version          = "0.0.1"
  s.summary          = "图片压缩，拍照上传压缩图片，比例压缩，data压缩，方便好用"
  s.description      = <<-DESC
                        图片压缩，拍照上传压缩图片，比例压缩，data压缩，方便好用
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  s.screenshots      = "http://120.27.93.73/files/myPublicProject/YXJImageCompressor1.png"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/EasySwift/YXJImageCompressor.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJImageCompressor"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJImageCompressor"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  #s.resource = 'pod/*.bundle'
  
  s.frameworks = 'UIKit'

end

