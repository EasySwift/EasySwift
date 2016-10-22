#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EasyDropDownMenu"
  s.version          = "1.1"
  s.summary          = "类似美团，糯米，大众点评的筛选排序菜单"
  s.description      = <<-DESC
                      类似美团，糯米，大众点评的筛选排序菜单，支持文字以及图片选择状态的记录
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/EasyDropDownMenu.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/EasyDropDownMenu"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = "10.12"

  s.requires_arc = true
  s.module_name = "EasyDropDownMenu"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  s.resource = 'pod/*.bundle'

  s.frameworks = 'UIKit'

end

