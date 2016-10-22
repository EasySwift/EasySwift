#
# Be sure to run `pod lib lint YXJTagView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJTagView"
  s.version          = "0.0.1"
  s.summary          = "及其强大的标签框架，不仅可以填充文字，任意视图都可以。"
  s.description      = <<-DESC
                      及其强大的标签框架，不仅可以填充文字，任意视图都可以。
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/YXJTagView.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJTagView"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJTagView"

  s.source_files = 'Pod/*'

  s.frameworks = 'UIKit'

end

