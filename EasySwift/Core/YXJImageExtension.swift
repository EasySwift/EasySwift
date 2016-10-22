//
//  AFImageExtension.swift
//
//  AFImageHelper
//  Version 3.0.2
//
//  Created by Melvin Rivera on 7/5/14.
//  Copyright (c) 2014 All Forces. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import CoreGraphics

public enum UIImageContentMode {
    case scaleToFill, scaleAspectFit, scaleAspectFill
}

public extension UIImage {

    /**
     A singleton shared NSURL cache used for images from URL
     */
//    fileprivate class func sharedCache() -> NSCache<AnyObject, AnyObject>! {
//        struct StaticSharedCache {
//            static var sharedCache: NSCache?? = nil
//            static var onceToken: Int = 0
//        }
//        dispatch_once(&StaticSharedCache.onceToken) {
//            StaticSharedCache.sharedCache = NSCache()
//        }
//        return StaticSharedCache.sharedCache!
//    }

    // MARK: Image from solid color
    /**
     Creates a new solid color image.

     - Parameter color: The color to fill the image with.
     - Parameter size: Image size (defaults: 10x10)

     - Returns A new image
     */
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 10, height: 10))
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    // MARK:  Image from gradient colors
    /**
     Creates a gradient color image.

     - Parameter gradientColors: An array of colors to use for the gradient.
     - Parameter size: Image size (defaults: 10x10)

     - Returns A new image
     */
    convenience init?(gradientColors: [UIColor], size: CGSize = CGSize(width: 10, height: 10))
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map { (color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    /**
     Applies gradient color overlay to an image.

     - Parameter gradientColors: An array of colors to use for the gradient.
     - Parameter blendMode: The blending type to use.

     - Returns A new image
     */
    func applyGradientColors(_ gradientColors: [UIColor], blendMode: CGBlendMode = CGBlendMode.normal) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(blendMode)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.draw(self.cgImage!, in: rect)
        // Create gradient
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map { (color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        // Apply gradient
        context?.clip(to: rect, mask: self.cgImage!)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!;
    }

    // MARK: Image with Text
    /**
     Creates a text label image.

     - Parameter text: The text to use in the label.
     - Parameter font: The font (default: System font of size 18)
     - Parameter color: The text color (default: White)
     - Parameter backgroundColor: The background color (default:Gray).
     - Parameter size: Image size (default: 10x10)
     - Parameter offset: Center offset (default: 0x0)

     - Returns A new image
     */
    convenience init?(text: String, font: UIFont = UIFont.systemFont(ofSize: 18), color: UIColor = UIColor.white, backgroundColor: UIColor = UIColor.gray, size: CGSize = CGSize(width: 100, height: 100), offset: CGPoint = CGPoint(x: 0, y: 0))
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.font = font
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        let image = UIImage(fromView: label)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    // MARK: Image from UIView
    /**
     Creates an image from a UIView.

     - Parameter fromView: The source view.

     - Returns A new image
     */
    convenience init?(fromView view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        // view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    // MARK: Image with Radial Gradient
    // Radial background originally from: http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html
    /**
     Creates a radial gradient.

     - Parameter startColor: The start color
     - Parameter endColor: The end color
     - Parameter radialGradientCenter: The gradient center (default:0.5,0.5).
     - Parameter radius: Radius size (default: 0.5)
     - Parameter size: Image size (default: 100x100)

     - Returns A new image
     */
    convenience init?(startColor: UIColor, endColor: UIColor, radialGradientCenter: CGPoint = CGPoint(x: 0.5, y: 0.5), radius: Float = 0.5, size: CGSize = CGSize(width: 100, height: 100))
    {

        // Init
        UIGraphicsBeginImageContextWithOptions(size, true, 0)

        let num_locations: Int = 2
        let locations: [CGFloat] = [0.0, 1.0] as [CGFloat]

        let startComponents = startColor.cgColor.components
        let endComponents = endColor.cgColor.components

        let components: [CGFloat] = [startComponents![0], startComponents![1], startComponents![2], startComponents![3], endComponents![0], endComponents![1], endComponents![2], endComponents![3]]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: num_locations)

        // Normalize the 0-1 ranged inputs to the width of the image
        let aCenter = CGPoint(x: radialGradientCenter.x * size.width, y: radialGradientCenter.y * size.height)
        let aRadius = CGFloat(min(size.width, size.height)) * CGFloat(radius)

        // Draw it
        UIGraphicsGetCurrentContext()?.drawRadialGradient(gradient!, startCenter: aCenter, startRadius: 0, endCenter: aCenter, endRadius: aRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        // Clean up
        UIGraphicsEndImageContext()
    }

    // MARK: Alpha

    /**
     Returns true if the image has an alpha layer.
     */
//    func hasAlpha() -> Bool
//    {
//        let alpha = self.cgImage?.alphaInfo
//        switch alpha {
//        case .first, .last, .premultipliedFirst, .premultipliedLast:
//            return true
//        default:
//            return false
//        }
//    }

    /**
     Returns a copy of the given image, adding an alpha channel if it doesn't already have one.
     */
//    func applyAlpha() -> UIImage?
//    {
//        if hasAlpha() {
//            return self
//        }
//
//        let imageRef = self.cgImage;
//        let width = imageRef?.width;
//        let height = imageRef?.height;
//        let colorSpace = imageRef?.colorSpace
//
//        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
//        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
//        let offscreenContext = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
//
//        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
//        offscreenContext?.draw(imageRef!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
//        let imageWithAlpha = UIImage(cgImage: (offscreenContext?.makeImage()!)!)
//        return imageWithAlpha
//    }

    /**
     Returns a copy of the image with a transparent border of the given size added around its edges. i.e. For rotating an image without getting jagged edges.

     - Parameter padding: The padding amount.

     - Returns A new image.
     */
//    func applyPadding(_ padding: CGFloat) -> UIImage?
//    {
//        // If the image does not have an alpha layer, add one
//        let image = self.applyAlpha()
//        if image == nil {
//            return nil
//        }
//        let rect = CGRect(x: 0, y: 0, width: size.width + padding * 2, height: size.height + padding * 2)
//
//        // Build a context that's the same dimensions as the new size
//        let colorSpace = self.cgImage?.colorSpace
//        let bitmapInfo = self.cgImage?.bitmapInfo
//        let bitsPerComponent = self.cgImage?.bitsPerComponent
//        let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: bitsPerComponent!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
//
//        // Draw the image in the center of the context, leaving a gap around the edges
//        let imageLocation = CGRect(x: padding, y: padding, width: image!.size.width, height: image!.size.height)
//        context?.draw(self.cgImage!, in: imageLocation)
//
//        // Create a mask to make the border transparent, and combine it with the image
//        let transparentImage = UIImage(cgImage: (context?.makeImage()?.masking(imageRefWithPadding(padding, size: rect.size))!)!)
//        return transparentImage
//    }

    /**
     Creates a mask that makes the outer edges transparent and everything else opaque. The size must include the entire mask (opaque part + transparent border).

     - Parameter padding: The padding amount.
     - Parameter size: The size of the image.

     - Returns A Core Graphics Image Ref
     */
    fileprivate func imageRefWithPadding(_ padding: CGFloat, size: CGSize) -> CGImage
    {
        // Build a context that's the same dimensions as the new size
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        // Start with a mask that's entirely transparent
        context?.setFillColor(UIColor.black.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // Make the inner part (within the border) opaque
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(CGRect(x: padding, y: padding, width: size.width - padding * 2, height: size.height - padding * 2))
        // Get an image of the context
        let maskImageRef = context?.makeImage()
        return maskImageRef!
    }

    // MARK: Crop

    /**
     Creates a cropped copy of an image.

     - Parameter bounds: The bounds of the rectangle inside the image.

     - Returns A new image
     */
    func crop(_ bounds: CGRect) -> UIImage?
    {
        return UIImage(cgImage: (self.cgImage?.cropping(to: bounds)!)!,
            scale: 0.0, orientation: self.imageOrientation)
    }

    func cropToSquare() -> UIImage? {
        let size = CGSize(width: self.size.width * self.scale, height: self.size.height * self.scale)
        let shortest = min(size.width, size.height)
        let left: CGFloat = size.width > shortest ? (size.width - shortest) / 2: 0
        let top: CGFloat = size.height > shortest ? (size.height - shortest) / 2: 0
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let insetRect = rect.insetBy(dx: left, dy: top)
        return crop(insetRect)
    }

    // MARK: Resize

    /**
     Creates a resized copy of an image.

     - Parameter size: The new size of the image.
     - Parameter contentMode: The way to handle the content in the new size.

     - Returns A new image
     */
    func resize(_ size: CGSize, contentMode: UIImageContentMode = .scaleToFill) -> UIImage?
    {
        let horizontalRatio = size.width / self.size.width;
        let verticalRatio = size.height / self.size.height;
        var ratio: CGFloat!

        switch contentMode {
        case .scaleToFill:
            ratio = 1
        case .scaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .scaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)

        // Fix for a colorspace / transparency issue that affects some types of
        // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        let transform = CGAffineTransform.identity

        // Rotate and/or flip the image if required by its orientation
        context?.concatenate(transform);

        // Set the quality level to use when rescaling
        context!.interpolationQuality = CGInterpolationQuality(rawValue: 3)!

        // CGContextSetInterpolationQuality(context, CGInterpolationQuality(kCGInterpolationHigh.value))

        // Draw into the context; this scales the image
        context?.draw(self.cgImage!, in: rect)

        // Get the resized image from the context and a UIImage
        let newImage = UIImage(cgImage: (context?.makeImage()!)!, scale: self.scale, orientation: self.imageOrientation)
        return newImage;
    }

    // MARK: Corner Radius

    /**
     Creates a new image with rounded corners.

     - Parameter cornerRadius: The corner radius.

     - Returns A new image
     */
//    func roundCorners(_ cornerRadius: CGFloat) -> UIImage?
//    {
//        // If the image does not have an alpha layer, add one
//        let imageWithAlpha = applyAlpha()
//        if imageWithAlpha == nil {
//            return nil
//        }
//
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        let width = imageWithAlpha?.cgImage?.width
//        let height = imageWithAlpha?.cgImage?.height
//        let bits = imageWithAlpha?.cgImage?.bitsPerComponent
//        let colorSpace = imageWithAlpha?.cgImage?.colorSpace
//        let bitmapInfo = imageWithAlpha?.cgImage?.bitmapInfo
//        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
//        let rect = CGRect(x: 0, y: 0, width: CGFloat(width!) * scale, height: CGFloat(height!) * scale)
//
//        context?.beginPath()
//        if (cornerRadius == 0) {
//            context?.addRect(rect)
//        } else {
//            context?.saveGState()
//            context?.translateBy(x: rect.minX, y: rect.minY)
//            context?.scaleBy(x: cornerRadius, y: cornerRadius)
//            let fw = rect.size.width / cornerRadius
//            let fh = rect.size.height / cornerRadius
//            context?.move(to: CGPoint(x: fw, y: fh / 2))
//            CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1)
//            CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1)
//            CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1)
//            CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1)
//            context?.restoreGState()
//        }
//        context?.closePath()
//        context?.clip()
//
//        context?.draw((imageWithAlpha?.cgImage)!, in: rect)
//        let image = UIImage(cgImage: (context?.makeImage()!)!, scale: scale, orientation: .up)
//        UIGraphicsEndImageContext()
//        return image
//    }

    /**
     Creates a new image with rounded corners and border.

     - Parameter cornerRadius: The corner radius.
     - Parameter border: The size of the border.
     - Parameter color: The color of the border.

     - Returns A new image
     */
//    func roundCorners(_ cornerRadius: CGFloat, border: CGFloat, color: UIColor) -> UIImage?
//    {
//        return roundCorners(cornerRadius)?.applyBorder(border, color: color)
//    }
//
//    /**
//     Creates a new circle image.
//
//     - Returns A new image
//     */
//    func roundCornersToCircle() -> UIImage?
//    {
//        let shortest = min(size.width, size.height)
//        return cropToSquare()?.roundCorners(shortest / 2)
//    }

    /**
     Creates a new circle image with a border.

     - Parameter border :CGFloat The size of the border.
     - Parameter color :UIColor The color of the border.

     - Returns UIImage?
     */
//    func roundCornersToCircle(border: CGFloat, color: UIColor) -> UIImage?
//    {
//        let shortest = min(size.width, size.height)
//        return cropToSquare()?.roundCorners(shortest / 2, border: border, color: color)
//    }

    // MARK: Border

    /**
     Creates a new image with a border.

     - Parameter border: The size of the border.
     - Parameter color: The color of the border.

     - Returns A new image
     */
    func applyBorder(_ border: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = self.cgImage?.width
        let height = self.cgImage?.height
        let bits = self.cgImage?.bitsPerComponent
        let colorSpace = self.cgImage?.colorSpace
        let bitmapInfo = self.cgImage?.bitmapInfo
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        context?.setLineWidth(border)
        let rect = CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale)
        let inset = rect.insetBy(dx: border * scale, dy: border * scale)
        context?.strokeEllipse(in: inset)
        context?.draw(self.cgImage!, in: inset)
        let image = UIImage(cgImage: (context?.makeImage()!)!)
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: Image From URL

    /**
     Creates a new image from a URL with optional caching. If cached, the cached image is returned. Otherwise, a place holder is used until the image from web is returned by the closure.

     - Parameter url: The image URL.
     - Parameter placeholder: The placeholder image.
     - Parameter shouldCacheImage: Weather or not we should cache the NSURL response (default: true)
     - Parameter closure: Returns the image from the web the first time is fetched.

     - Returns A new image
     */
//    class func imageFromURL(_ url: String, placeholder: UIImage, shouldCacheImage: Bool = true, closure: @escaping (_ image: UIImage?) -> ()) -> UIImage?
//    {
//        // From Cache
//        if shouldCacheImage {
//            if UIImage.sharedCache().object(forKey: url as AnyObject) != nil {
//                closure(nil)
//                return UIImage.sharedCache().object(forKey: url as AnyObject) as! UIImage!
//            }
//        }
//        // Fetch Image
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        if let nsURL = URL(string: url) {
//            session.dataTask(with: nsURL, completionHandler: { (data, response, error) -> Void in
//                if (error != nil) {
//                    DispatchQueue.main.async {
//                        closure(nil)
//                    }
//                }
//                if let data = data, let image = UIImage(data: data) {
//                    if shouldCacheImage {
//                        UIImage.sharedCache().setObject(image, forKey: url as AnyObject)
//                    }
//                    DispatchQueue.main.async {
//                        closure(image)
//                    }
//                }
//                session.finishTasksAndInvalidate()
//            }).resume()
//        }
//        return placeholder
//    }
//
    // MARK: 旋转
    public func swifRotate(_ angle: Float) -> UIImage {
        var result: UIImage?
        let imageSize: CGSize = self.size
        var canvasSize = CGSize.zero

        let newAngle = fmodf(angle, 360)

        if (90 == newAngle || 270 == newAngle)
        {
            canvasSize.width = self.size.height;
            canvasSize.height = self.size.width;
        }
        else if (0 == newAngle || 180 == newAngle)
        {
            canvasSize.width = self.size.width;
            canvasSize.height = self.size.height;
        }

        UIGraphicsBeginImageContext(canvasSize);

        let bitmap = UIGraphicsGetCurrentContext();
        bitmap?.translateBy(x: canvasSize.width / 2, y: canvasSize.height / 2);
        let rou: CGFloat = CGFloat(M_PI / 180 * Double(newAngle))
        bitmap?.rotate(by: rou)
        bitmap?.scaleBy(x: 1.0, y: -1.0);
        bitmap?.draw(self.cgImage!, in: CGRect(x: -CGFloat((imageSize.width / 2)), y: -CGFloat((imageSize.height / 2)), width: imageSize.width, height: imageSize.height));

        result = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        return result!
    }
    public func swifRotateCW90() {
        self.swifRotate(270)
    }
    public func swifRotateCW180() {
        self.swifRotate(180)
    }
    public func swifRotateCW270() {
        self.swifRotate(90)
    }

    // MARK: 通过宽度获取等比例缩放的高度
    public func getHightFromFitWidth(_ width: CGFloat) -> CGFloat {
        return width * self.size.height / self.size.width
    }
    // MARK: 通过高度获取等比例缩放的宽度
    public func getWidthFromFitHight(_ height: CGFloat) -> CGFloat {
        return height * self.size.width / self.size.height
    }
}
