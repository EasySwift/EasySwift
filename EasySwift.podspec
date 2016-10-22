#
# Be sure to run `pod lib lint EasySwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EasySwift"
  s.version          = "1.2.6"
  s.summary          = "打造最好的swift开源项目"
  s.description      = <<-DESC
                      This is the most simple way to use swift, which is a complete throughout the entire iOS development of the most convenient, the most simple, the most perfect framework to build the heart.
                       DESC
  s.homepage         = "https://github.com/stubbornnessness"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "stubbornness1219" => "18223847097@163.com" }
  s.source           = { :git => "https://github.com/stubbornnessness/EasySwift.git", :tag => s.version.to_s }
  # s.source           = { :git => "/Users/yxj/Documents/EasySwift"}
  # s.social_media_url = 'https://twitter.com/yxj'
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.module_name = "EasySwift"

  s.default_subspec = 'Core' , 'FlexboxKit', 'CoreData', 'Pinyin', 'Gumbo', 'ObjectiveGumbo', 'FLSideSlipViewController', 'SwiftRegex', 'URLManager', 'Watch' , 'TLCityPicker'

  s.subspec 'Core' do |core|
    core.source_files = 'Pod/Core/*'
    core.frameworks = 'UIKit' , 'CoreData' , 'JavaScriptCore'
  end

  s.subspec 'FlexboxKit' do |ss|
    ss.public_header_files = 'Pod/Lib/FlexboxKit/*.h'
    ss.source_files = 'Pod/Lib/FlexboxKit/*'
  end

  s.subspec 'CoreData' do |ss|
    ss.source_files = 'Pod/Lib/CoreData/*'
    ss.dependency 'EasySwift/Core'
  end

  s.subspec 'Pinyin' do |ss|
    ss.public_header_files = 'Pod/Lib/Pinyin/*.h'
    ss.source_files = 'Pod/Lib/Pinyin/*'
  end

  s.subspec 'Gumbo' do |ss|
    ss.public_header_files = 'Pod/Lib/Gumbo/*.h'
    ss.source_files = 'Pod/Lib/Gumbo/*'
  end

  s.subspec 'ObjectiveGumbo' do |ss|
    ss.public_header_files = 'Pod/Lib/ObjectiveGumbo/*.h'
    ss.source_files = 'Pod/Lib/ObjectiveGumbo/*'
    ss.dependency 'EasySwift/Gumbo'
  end

  s.subspec 'FLSideSlipViewController' do |ss|
    ss.public_header_files = 'Pod/Lib/FLSideSlipViewController/*.h'
    ss.source_files = 'Pod/Lib/FLSideSlipViewController/*'
  end

  s.subspec 'SwiftRegex' do |ss|
    ss.source_files = 'Pod/Lib/SwiftRegex/*'
  end

  s.subspec 'URLManager' do |ss|
    ss.public_header_files = 'Pod/Lib/URLManager/*.h'
    ss.source_files = 'Pod/Lib/URLManager/*'
  end

  s.subspec 'Watch' do |ss|
    ss.source_files = 'Pod/Lib/Watch/*'
  end  

  s.subspec 'TLCityPicker' do |ss|
    ss.public_header_files = 'Pod/Lib/TLCityPicker/*.h'
    ss.source_files = 'Pod/Lib/TLCityPicker/*'
  end

  s.dependency 'Bond'
  s.dependency 'SnapKit'
  s.dependency 'Colours'
  s.dependency 'GCDSwift'
  s.dependency 'Alamofire'
  s.dependency 'swiftScan' 
  s.dependency 'LCCoolHUD'  
  s.dependency 'MJRefresh' , '3.1.0'
  s.dependency 'Kingfisher'
  s.dependency 'SwiftyJSON'
  s.dependency 'Loggerithm'
  s.dependency 'SwiftString'
  s.dependency 'HanekeSwift'
  s.dependency 'ObjectMapper'
  s.dependency 'SystemServices'
  s.dependency 'ZLPhotoBrowser' 
  s.dependency 'MWPhotoBrowser'
  s.dependency 'TYAlertController' 
  s.dependency 'AXBadgeView-Swift'  
  s.dependency 'HCSStarRatingView'#评分框架   
  s.dependency 'IQKeyboardManager'
  s.dependency 'ReachabilitySwift'
  s.dependency 'RainbowNavigation'
  s.dependency 'TTTAttributedLabel'
  s.dependency 'TOWebViewController'
  s.dependency 'APAddressBook/Swift'
  s.dependency 'CYLTabBarController'
  s.dependency 'UIButton-SSEdgeInsets'
  s.dependency 'DKChainableAnimationKit'  
  s.dependency 'FORScrollViewEmptyAssistant' 
  s.dependency 'UITableView+FDTemplateLayoutCell'
  
  s.dependency 'EasySwift/FlexboxKit'
  s.dependency 'EasySwift/URLManager'
  s.dependency 'EasySwift/SwiftRegex'
  s.dependency 'EasySwift/Watch'
  s.dependency 'EasySwift/Pinyin'
  s.dependency 'EasySwift/ObjectiveGumbo'
  s.dependency 'EasyEmoji'
  s.dependency 'EasyDropDownMenu'
  s.dependency 'EasySearchBar'
  s.dependency 'EasyCountDownButton'
  s.dependency 'YXJXibView'
  s.dependency 'YXJTagView'
  s.dependency 'YXJKxMenu'
  s.dependency 'YXJLinksButton' 
  s.dependency 'YXJCycleView'
  s.dependency 'YXJPageController'
  s.dependency 'YXJOnePixeLine'
  s.dependency 'YXJSlideBar'
  s.dependency 'YXJSwipeTableViewCell'
  s.dependency 'YXJImageCompressor'
  s.dependency 'YXJPullScale'

  s.frameworks = 'UIKit'

end

