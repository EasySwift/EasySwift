#!/bin/sh
set -e

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

install_framework()
{
  if [ -r "${BUILT_PRODUCTS_DIR}/$1" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$1"
  elif [ -r "${BUILT_PRODUCTS_DIR}/$(basename "$1")" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$(basename "$1")"
  elif [ -r "$1" ]; then
    local source="$1"
  fi

  local destination="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

  if [ -L "${source}" ]; then
      echo "Symlinked..."
      source="$(readlink "${source}")"
  fi

  # use filter instead of exclude so missing patterns dont' throw errors
  echo "rsync -av --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" --filter \"- Headers\" --filter \"- PrivateHeaders\" --filter \"- Modules\" \"${source}\" \"${destination}\""
  rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers" --filter "- PrivateHeaders" --filter "- Modules" "${source}" "${destination}"

  local basename
  basename="$(basename -s .framework "$1")"
  binary="${destination}/${basename}.framework/${basename}"
  if ! [ -r "$binary" ]; then
    binary="${destination}/${basename}"
  fi

  # Strip invalid architectures so "fat" simulator / device frameworks work on device
  if [[ "$(file "$binary")" == *"dynamically linked shared library"* ]]; then
    strip_invalid_archs "$binary"
  fi

  # Resign the code if required by the build settings to avoid unstable apps
  code_sign_if_enabled "${destination}/$(basename "$1")"

  # Embed linked Swift runtime libraries. No longer necessary as of Xcode 7.
  if [ "${XCODE_VERSION_MAJOR}" -lt 7 ]; then
    local swift_runtime_libs
    swift_runtime_libs=$(xcrun otool -LX "$binary" | grep --color=never @rpath/libswift | sed -E s/@rpath\\/\(.+dylib\).*/\\1/g | uniq -u  && exit ${PIPESTATUS[0]})
    for lib in $swift_runtime_libs; do
      echo "rsync -auv \"${SWIFT_STDLIB_PATH}/${lib}\" \"${destination}\""
      rsync -auv "${SWIFT_STDLIB_PATH}/${lib}" "${destination}"
      code_sign_if_enabled "${destination}/${lib}"
    done
  fi
}

# Signs a framework with the provided identity
code_sign_if_enabled() {
  if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" -a "${CODE_SIGNING_REQUIRED}" != "NO" -a "${CODE_SIGNING_ALLOWED}" != "NO" ]; then
    # Use the current code_sign_identitiy
    echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} ${OTHER_CODE_SIGN_FLAGS} --preserve-metadata=identifier,entitlements \"$1\""
    /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} ${OTHER_CODE_SIGN_FLAGS} --preserve-metadata=identifier,entitlements "$1"
  fi
}

# Strip invalid architectures
strip_invalid_archs() {
  binary="$1"
  # Get architectures for current file
  archs="$(lipo -info "$binary" | rev | cut -d ':' -f1 | rev)"
  stripped=""
  for arch in $archs; do
    if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
      # Strip non-valid architectures in-place
      lipo -remove "$arch" -output "$binary" "$binary" || exit 1
      stripped="$stripped $arch"
    fi
  done
  if [[ "$stripped" ]]; then
    echo "Stripped $binary of architectures:$stripped"
  fi
}


if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_framework "$BUILT_PRODUCTS_DIR/APAddressBook/APAddressBook.framework"
  install_framework "$BUILT_PRODUCTS_DIR/AXBadgeView-Swift/AXBadgeView_Swift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Alamofire/Alamofire.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Bond/Bond.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CYLTabBarController/CYLTabBarController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Colours/Colours.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DACircularProgress/DACircularProgress.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DKChainableAnimationKit/DKChainableAnimationKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DZNEmptyDataSet/DZNEmptyDataSet.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyCountDownButton/EasyCountDownButton.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyDropDownMenu/EasyDropDownMenu.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyEmoji/EasyEmoji.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasySearchBar/EasySearchBar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasySwift/EasySwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FORScrollViewEmptyAssistant/FORScrollViewEmptyAssistant.framework"
  install_framework "$BUILT_PRODUCTS_DIR/GCDSwift/GCDSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HCSStarRatingView/HCSStarRatingView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HanekeSwift/Haneke.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IQKeyboardManager/IQKeyboardManager.framework"
  install_framework "$BUILT_PRODUCTS_DIR/JGProgressHUD/JGProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Kingfisher/Kingfisher.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LCCoolHUD/LCCoolHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LCLoadingHUD/LCLoadingHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Loggerithm/Loggerithm.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MBProgressHUD/MBProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MJRefresh/MJRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MWPhotoBrowser/MWPhotoBrowser.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ObjectMapper/ObjectMapper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RainbowNavigation/RainbowNavigation.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ReachabilitySwift/ReachabilitySwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SDWebImage/SDWebImage.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SnapKit/SnapKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftString/SwiftString.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftyJSON/SwiftyJSON.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SystemServices/SystemServices.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TOWebViewController/TOWebViewController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TTTAttributedLabel/TTTAttributedLabel.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TYAlertController/TYAlertController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/UIButton-SSEdgeInsets/UIButton_SSEdgeInsets.framework"
  install_framework "$BUILT_PRODUCTS_DIR/UITableView+FDTemplateLayoutCell/UITableView_FDTemplateLayoutCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJCycleView/YXJCycleView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJImageCompressor/YXJImageCompressor.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJKxMenu/YXJKxMenu.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJLinksButton/YXJLinksButton.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJOnePixeLine/YXJOnePixeLine.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJPageController/YXJPageController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJPullScale/YXJPullScale.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJSlideBar/YXJSlideBar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJSwipeTableViewCell/YXJSwipeTableViewCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJTagView/YXJTagView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJXibView/YXJXibView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ZLPhotoBrowser/ZLPhotoBrowser.framework"
  install_framework "$BUILT_PRODUCTS_DIR/swiftScan/swiftScan.framework"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_framework "$BUILT_PRODUCTS_DIR/APAddressBook/APAddressBook.framework"
  install_framework "$BUILT_PRODUCTS_DIR/AXBadgeView-Swift/AXBadgeView_Swift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Alamofire/Alamofire.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Bond/Bond.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CYLTabBarController/CYLTabBarController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Colours/Colours.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DACircularProgress/DACircularProgress.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DKChainableAnimationKit/DKChainableAnimationKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DZNEmptyDataSet/DZNEmptyDataSet.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyCountDownButton/EasyCountDownButton.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyDropDownMenu/EasyDropDownMenu.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasyEmoji/EasyEmoji.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasySearchBar/EasySearchBar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/EasySwift/EasySwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FORScrollViewEmptyAssistant/FORScrollViewEmptyAssistant.framework"
  install_framework "$BUILT_PRODUCTS_DIR/GCDSwift/GCDSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HCSStarRatingView/HCSStarRatingView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HanekeSwift/Haneke.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IQKeyboardManager/IQKeyboardManager.framework"
  install_framework "$BUILT_PRODUCTS_DIR/JGProgressHUD/JGProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Kingfisher/Kingfisher.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LCCoolHUD/LCCoolHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LCLoadingHUD/LCLoadingHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Loggerithm/Loggerithm.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MBProgressHUD/MBProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MJRefresh/MJRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MWPhotoBrowser/MWPhotoBrowser.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ObjectMapper/ObjectMapper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RainbowNavigation/RainbowNavigation.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ReachabilitySwift/ReachabilitySwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SDWebImage/SDWebImage.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SnapKit/SnapKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftString/SwiftString.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftyJSON/SwiftyJSON.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SystemServices/SystemServices.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TOWebViewController/TOWebViewController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TTTAttributedLabel/TTTAttributedLabel.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TYAlertController/TYAlertController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/UIButton-SSEdgeInsets/UIButton_SSEdgeInsets.framework"
  install_framework "$BUILT_PRODUCTS_DIR/UITableView+FDTemplateLayoutCell/UITableView_FDTemplateLayoutCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJCycleView/YXJCycleView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJImageCompressor/YXJImageCompressor.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJKxMenu/YXJKxMenu.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJLinksButton/YXJLinksButton.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJOnePixeLine/YXJOnePixeLine.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJPageController/YXJPageController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJPullScale/YXJPullScale.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJSlideBar/YXJSlideBar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJSwipeTableViewCell/YXJSwipeTableViewCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJTagView/YXJTagView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/YXJXibView/YXJXibView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ZLPhotoBrowser/ZLPhotoBrowser.framework"
  install_framework "$BUILT_PRODUCTS_DIR/swiftScan/swiftScan.framework"
fi
