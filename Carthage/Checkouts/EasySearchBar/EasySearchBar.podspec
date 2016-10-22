#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EasySearchBar"
  s.version          = "0.0.1"
  s.summary          = "a little descript for EasySearchBar"
  s.description      = <<-DESC
                      自定义SearchBar
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/EasySearchBar.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/EasySearchBar"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "EasySearchBar"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  #s.resource = 'pod/*.bundle'

  s.frameworks = 'UIKit'

end

