
//  EZWatch.swift
//  medical
//
//  Created by zhuchao on 15/4/29.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation

func watchForChangesToFilePath(_ filePath:String,callback:@escaping ()->()) {
    let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
    let fileDescriptor = open(filePath, O_EVTONLY)
    
    if fileDescriptor <= 0 {
        return
    }
    assert(fileDescriptor > 0, "Error could subscribe to events for file at path: \(filePath)")
    let source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileDescriptor, eventMask: DispatchSource.FileSystemEvent.delete | DispatchSource.FileSystemEvent.write | DispatchSource.FileSystemEvent.extend, queue: queue)
    source.setEventHandler{
        let flags = source.data
        if flags != 0 {
            source.cancel()
            DispatchQueue.main.async{
                 callback()
            }
            let popTime = DispatchTime.now() + Double(Int64(0.5*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            queue.asyncAfter(deadline: popTime){
                watchForChangesToFilePath(filePath, callback: callback)
            }
        }
    }
    source.setCancelHandler{
        close(fileDescriptor)
    }
    source.resume()
}





