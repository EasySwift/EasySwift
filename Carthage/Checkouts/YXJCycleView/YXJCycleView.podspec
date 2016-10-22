#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJCycleView"
  s.version          = "0.0.1"
  s.summary          = "可能是史上最好用的循环视图框架。本地图片轮播图，远程图片轮播图，本地任意视图轮播图，app介绍页样样在行。支持缓存"
  s.description      = <<-DESC
                       任意视图的无限循环轮播图，可以是本地图片，可以是任意的view，可以是远程图片，再加文字描述岂不更好，pageController也支持高度自定义。几乎可以满足所有循环视图的需求，不仅是轮播组件，做app首次安装或者更新的介绍页也照样能胜任。支持缓存
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  s.screenshots      = "http://120.27.93.73/files/myPublicProject/YXJCycleView1.gif"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/EasySwift/YXJCycleView.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJCycleView"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJCycleView"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  #s.resource = 'pod/*.bundle'

  s.dependency 'YXJPageController'
  
  s.frameworks = 'UIKit'

end

