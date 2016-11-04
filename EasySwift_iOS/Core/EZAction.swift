//
//  Action.swift
//  medical
//
//  Created by zhuchao on 15/4/25.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import Alamofire
import Haneke
import Bond
import Reachability

public var HOST_URL = "" // 服务端域名:端口
public var CODE_KEY = "" // 错误码key,暂不支持路径 如 code
public var RIGHT_CODE = 0 // 正确校验码
public var MSG_KEY = "" // 消息提示msg,暂不支持路径 如 msg

private var networkReachabilityHandle: UInt8 = 2;

open class EZAction: NSObject {

    // 使用缓存策略 仅首次读取缓存
    open class func SEND_IQ_CACHE (_ req: EZRequest) {
        req.useCache = true
        req.dataFromCache = req.isFirstRequest
        self.Send(req)
    }

    // 使用缓存策略 优先从缓存读取
    open class func SEND_CACHE (_ req: EZRequest) {
        req.useCache = true
        req.dataFromCache = true
        self.Send(req)
    }

    // 不使用缓存策略
    open class func SEND (_ req: EZRequest) {
        req.useCache = false
        req.dataFromCache = false
        self.Send(req)
    }

    open class func Send (_ req: EZRequest) {
        var url = ""
        var requestParams = Dictionary<String, AnyObject>()

        if !req.staticPath.characters.isEmpty {
            url = req.staticPath
        } else {
            if req.scheme.characters.isEmpty {
                req.scheme = "http"
            }
            if req.host.characters.isEmpty {
                req.host = HOST_URL
            }
            url = req.scheme + "://" + req.host + req.path
            if req.appendPathInfo.characters.isEmpty {
                requestParams = req.requestParams
            } else {
                url = url + req.appendPathInfo
            }
        }
        req.state.value = RequestState.sending

        req.op = req.manager
            .request(url, method: req.method, parameters: requestParams, encoding: req.parameterEncoding, headers: nil)
//        (req.method, url, parameters: requestParams, encoding: req.parameterEncoding)
            .validate(statusCode: 200 ..< 300)
            .validate(contentType: req.acceptableContentTypes)
            .responseJSON { response in
//                req.response = response
                if response.result.isFailure {
                    req.error = response.result.error
                    self.failed(req)
                } else {
                    req.output = response.result.value as! Dictionary<String, AnyObject>
                    self.checkCode(req)
                }
        }
        req.url = req.op?.request!.url
        self.getCacheJson(req)
    }

    open class func Upload (_ req: EZRequest) {
        var url = ""

        if !req.staticPath.characters.isEmpty {
            url = req.staticPath
        } else {
            if req.scheme.characters.isEmpty {
                req.scheme = "http"
            }
            if req.host.characters.isEmpty {
                req.host = HOST_URL
            }
            url = req.scheme + "://" + req.host + req.path
            if req.appendPathInfo.characters.isEmpty {
            } else {
                url = url + req.appendPathInfo
            }
        }

//        let urlRequest = urlRequestWithComponents(url, parameters: req.requestParams, images: req.files)
//
//        req.state.value = RequestState.sending
//        req.op = req.manager
//            .upload(urlRequest.0.urlRequest, data: urlRequest.1)
//            .validate(statusCode: 200 ..< 300)
//            .validate(contentType: req.acceptableContentTypes)
//            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                req.totalBytesWritten = Double(totalBytesWritten)
//                req.totalBytesExpectedToWrite = Double(totalBytesExpectedToWrite)
//                req.progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
//        }.responseJSON { response in
//                req.response = response
//                if response.result.isFailure {
//                    req.error = response.result.error
//                    self.failed(req)
//                } else {
//                    req.output = response.result.value as! Dictionary<String, AnyObject>
//                    self.checkCode(req)
//                }
//        }
        req.url = req.op?.request!.url
    }

    /**
     暂时只支持传图片

     - parameter urlString:  请求地址
     - parameter parameters: 请求参数集合
     - parameter images:     图片集合

     - returns:  (URLRequestConvertible, NSData)
     */
//    fileprivate class func urlRequestWithComponents(_ urlString: String, parameters: Dictionary<String, AnyObject>, images: [(name: String, fileName: String, data: Data)]) -> (URLRequestConvertible, Data) {
//
//        var mutableURLRequest = NSMutableURLRequest(url: URL(string: urlString)!)
//        mutableURLRequest.httpMethod = Alamofire.HTTPMethod.post.rawValue
//        let boundaryConstant = "myRandomBoundary12345";
//        let contentType = "multipart/form-data;boundary=" + boundaryConstant
//        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//
//        let uploadData = NSMutableData()
//
//        for img in images {
//            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
//            uploadData.append("Content-Disposition: form-data; name=\"\(img.name)\"; filename=\"\(img.fileName)\"\r\n".data(using: String.Encoding.utf8)!)
//            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
//            uploadData.append(img.data)
//        }
//
//        for (key, value) in parameters {
//            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
//            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
//        }
//        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
//
//        return (Alamofire.ParameterEncoding.encode(mutableURLRequest, parameters: []).0, uploadData)
//    }

//    open class func Download (_ req: EZRequest) {
//        req.state.value = RequestState.sending
//        req.op = req.manager
//            .download(.GET, req.downloadUrl, destination: { (temporaryURL, response) in
//                let directoryURL = FileManager.default.urls(for: .documentDirectory,
//                    in: .userDomainMask)[0]
//                return directoryURL.appendingPathComponent(req.targetPath + response.suggestedFilename!)
//        })
//            .validate(statusCode: 200 ..< 300)
//            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
//                req.totalBytesRead = Double(totalBytesRead)
//                req.totalBytesExpectedToRead = Double(totalBytesExpectedToRead)
//                req.progress = Double(totalBytesRead) / Double(totalBytesExpectedToRead)
//        }
//            .response { (request, response, _, error) in
//                if error != nil {
//                    req.error = error
//                    self.failed(req)
//                } else {
//                    req.state.value = RequestState.success
//                }
//        }
//        req.url = req.op?.request!.url
//    }

    fileprivate class func cacheJson (_ req: EZRequest) {
        if req.useCache {
            let cache = Shared.JSONCache
            cache.set(value: .Dictionary(req.output), key: req.cacheKey, formatName: HanekeGlobals.Cache.OriginalFormatName) { JSON in
                EZPrintln("Cache Success for key: \(req.cacheKey)")
            }
        }
    }

    fileprivate class func getCacheJson (_ req: EZRequest) {
        let cache = Shared.JSONCache
        cache.fetch(key: req.cacheKey).onSuccess { JSON in
            req.output = JSON.dictionary
            if req.dataFromCache && !isEmpty(req.output as NSObject) {
                let delayTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    self.loadFromCache(req)
                }
            }
        }
    }

    fileprivate class func loadFromCache (_ req: EZRequest) {
        if req.needCheckCode && req.state.value != .success {
            req.codeKey = req.output[CODE_KEY] as? Int
            if req.codeKey == RIGHT_CODE {
                req.message = req.output[MSG_KEY] as? String
                req.state.value = RequestState.successFromCache
                EZPrintln("Fetch  Success from Cache by key: \(req.cacheKey)")
            } else {
                req.message = req.output[MSG_KEY] as? String
                req.state.value = RequestState.errorFromCache
                EZPrintln(req.message)
            }
        }
    }

    fileprivate class func checkCode (_ req: EZRequest) {
        if req.needCheckCode {
            req.codeKey = req.output[CODE_KEY] as? Int
            if req.codeKey == RIGHT_CODE {
                self.success(req)
                self.cacheJson(req)
            } else {
                self.error(req)
            }
        } else {
            req.state.value = RequestState.success
            self.cacheJson(req)
        }
    }

    fileprivate class func success (_ req: EZRequest) {
        req.isFirstRequest = false
        req.message = req.output[MSG_KEY] as? String
        if req.output.isEmpty {
            req.state.value = RequestState.error
        } else {
            req.state.value = RequestState.success
        }
    }

    fileprivate class func failed (_ req: EZRequest) {
        req.message = req.error.debugDescription
        req.state.value = RequestState.failed
        EZPrintln(req.message)
    }

    fileprivate class func error (_ req: EZRequest) {
        req.message = req.output[MSG_KEY] as? String
        req.state.value = RequestState.error
        EZPrintln(req.message)
    }

    /* Usage
     EZAction.networkReachability *->> Bond<NetworkStatus>{ status in
     switch (status) {
     case .NotReachable:
     EZPrintln("NotReachable")
     case .ReachableViaWiFi:
     EZPrintln("ReachableViaWiFi")
     case .ReachableViaWWAN:
     EZPrintln("ReachableViaWWAN")
     default:
     EZPrintln("default")
     }
     }
     */

//    open class var networkReachability: Observable<Reachability.NetworkStatus>? {
//        if let d: AnyObject = objc_getAssociatedObject(self, &networkReachabilityHandle) as AnyObject? {
//            return d as? Observable<Reachability.NetworkStatus>
//        } else {
//            do {
//                let reachability = try Reachability.NetworkStatus()
//                let d = Observable<Reachability.NetworkStatus>(reachability.currentReachabilityStatus)
//                reachability.whenReachable = { reachability in
//                    DispatchQueue.main.async {
//                        d.value = reachability.currentReachabilityStatus
//                    }
//                }
//                reachability.whenUnreachable = { reachability in
//                    DispatchQueue.main.async {
//                        d.value = reachability.currentReachabilityStatus
//                    }
//                }
//                try reachability.startNotifier()
//                objc_setAssociatedObject(self, &networkReachabilityHandle, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                return d
//            } catch {
//                print("Unable to create Reachability")
//                return nil
//            }
//        }
//    }
}
