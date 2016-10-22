#
# Be sure to run `pod lib lint YXJXibView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJXibView"
  s.version          = "0.0.1"
  s.summary          = "OC新建view勾选上xib文件即可自动关联，swift新建view已经不能勾选xib，但是又想用到xib，YXJXibView就能帮你搞定两秒钟搞定！"
  s.description      = <<-DESC
                      OC新建view勾选上xib文件即可自动关联，swift新建view已经不能勾选xib，但是又想用到xib，YXJXibView就能帮你搞定两秒钟搞定！
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/YXJXibView.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJXibView"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJXibView"

  s.source_files = 'Pod/*'

  s.frameworks = 'UIKit'

end

