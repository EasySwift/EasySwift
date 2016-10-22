#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXJPullScale"
  s.version          = "0.0.1"
  s.summary          = "UITableView,UICollectionView,UIScrollerView的顶部放大控件,不仅支持图片,也支持任意视图"
  s.description      = <<-DESC
                        UITableView,UICollectionView,UIScrollerView的顶部放大控件,不仅支持图片,也支持任意视图
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  s.screenshots      = "http://120.27.93.73/files/myPublicProject/YXJPullScale1.gif"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/EasySwift/YXJPullScale.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/YXJPullScale"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "YXJPullScale"

  s.source_files = 'Pod/*.{h,m}'
  s.public_header_files = 'Pod/*.h'
  #s.resource = 'pod/*.bundle' 

  s.dependency 'YXJXibView' 

  s.frameworks = 'UIKit'

end

