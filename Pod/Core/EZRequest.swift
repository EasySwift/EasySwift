//
//  Request.swift
//  medical
//
//  Created by zhuchao on 15/4/24.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import Bond
import Alamofire

public enum RequestState: Int {
    case `default` // 初始化状态
    case success
    case failed
    case sending
    case error
    case cancle
    case suspend
    case successFromCache
    case errorFromCache
}
private var enabledDynamicHandleRequest: UInt8 = 0
private var stateDynamicHandleRequest: UInt8 = 1
private var managerHandle: UInt8 = 2

open class EZRequest: NSObject {
    open var output = Dictionary<String, AnyObject>() // 序列化后的数据
    open var response: Response<AnyObject, NSError>? // 获取字符串数据
    open var error: Error? // 请求的错误
    open var state = Observable<RequestState>(.default) // Request状态
    open var url: URL? // 请求的链接
    open var message: String? // 错误消息或者服务器返回的MSG
    open var codeKey: Int? // 错误码返回

    // upload上传相关参数
    open var files = [(name: String, fileName: String, data: Data)]() // 请求的文件集合
    open var progress = 0.0 // 上传进度
    open var totalBytesWritten = 0.0 // 已上传数据大小
    open var totalBytesExpectedToWrite = 0.0 // 全部需要上传的数据大小

    // download下载相关参数
    open var downloadUrl: URLStringConvertible = ""// 下载图片URL
    open var targetPath = "" // 下载到路径
    open var totalBytesRead = 0.0 // 已下载传数据大小
    open var totalBytesExpectedToRead = 0.0 // 全部需要下载的数据大小

    open var scheme = "http" // 协议
    open var host = "" // 域名
    open var path = "" // 请求路径
    open var staticPath = "" // 其他路径
    open var method = Method.GET // 提交方式
    open var parameterEncoding = ParameterEncoding.url // 编码方式 Http头参数设置
    open var needCheckCode = true // 是否需要检查错误码

    open var acceptableContentTypes = ["application/json", "text/plain"] // 可接受的序列化返回数据的格式
    open var requestBlock: ((Void) -> ())?
    open var isFirstRequest = false

    // HttpHeader timeoutInterval Cookies 等都在这里设置
    open var sessionConfiguration: URLSessionConfiguration?
    open var timeoutRequest: TimeInterval? // request超时时间
    open var op: Request?

    open var requestNeedActive: Observable<Bool> {
        if let d: AnyObject = objc_getAssociatedObject(self, &enabledDynamicHandleRequest) as AnyObject? {
            return (d as? Observable<Bool>)!
        } else {
            let d = Observable<Bool>(false)
            d.observe { [weak self] v in if let s = self {
                if v {
                    d.value = false
                    s.requestBlock?()
                }
            } }
            objc_setAssociatedObject(self, &enabledDynamicHandleRequest, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return d
        }
    }

    var useCache = false
    var dataFromCache = false

    open var requestKey: String {
        return self.nameOfClass
    }

    open class var requestKey: String {
        return self.nameOfClass
    }

    open var requestParams: Dictionary<String, AnyObject> {
        return self.listProperties()
    }

    open var appendPathInfo: String {
        var pathInfo = self.pathInfo
        if pathInfo != nil && !(pathInfo!).characters.isEmpty {
            for (key, nsValue) in self.requestParams {
                let par = "(\\{\(key)\\})"
                let str = "\(nsValue)"
                pathInfo = (try? NSRegularExpression(pattern: par, options: NSRegularExpression.Options.caseInsensitive))?.stringByReplacingMatches(in: str, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, (pathInfo!).characters.count), withTemplate: str)
            }
        }
        if pathInfo == nil {
            pathInfo = ""
        }
        return pathInfo!
    }

    open var pathInfo: String? {
        return nil
    }

    // the key for cache
    open var cacheKey: String {
        if self.method == .GET {
            return self.url!.absoluteString.MD5
        } else if !isEmpty(self.requestParams) {
            return (self.url!.absoluteString + self.requestParams.joinPath).MD5
        } else {
            return self.url!.absoluteString.MD5
        }
    }

    open func suspend() {
        self.op?.suspend()
        self.state.value = .suspend
    }

    open func resume() {
        self.op?.resume()
        self.state.value = .sending
    }

    open func cancel() {
        self.op?.cancel()
        self.state.value = .cancle
    }

    open var manager: Manager {
        get {
            if let reqManager = objc_getAssociatedObject(self, &managerHandle) as? Manager {
                return reqManager
            } else if let configuration = sessionConfiguration {
                if let timeoutRequest = timeoutRequest {
                    configuration.timeoutIntervalForRequest = timeoutRequest
                } else {
                    configuration.timeoutIntervalForRequest = 10
                }
                let aManager = Alamofire.Manager(configuration: configuration)
                objc_setAssociatedObject(self, &managerHandle, aManager, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return aManager
            } else {
                Alamofire.Manager.sharedInstance.session.configuration.timeoutIntervalForRequest = 10
                return Alamofire.Manager.sharedInstance
            }
        } set(aManager) {
            objc_setAssociatedObject(self, &managerHandle, aManager, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
