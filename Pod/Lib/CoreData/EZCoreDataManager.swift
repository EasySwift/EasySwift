//
//  EZCoreDataManager.swift
//  medical
//
//  Created by zhuchao on 15/5/31.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation
import CoreData

private var managedObjectContextHandle:UInt8 = 0
private var persistentStoreCoordinatorHandle:UInt8 = 1
private var databaseNameHandle:UInt8 = 2
private var modelNameHandle:UInt8 = 3
private var managedObjectModelHandle:UInt8 = 4

open class EZCoreDataManager {
    
    fileprivate static let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
    
    open var databaseName: String {
        get {
            if let db = objc_getAssociatedObject(self, &databaseNameHandle) as? String {
                return db
            } else {
                return EZCoreDataManager.appName + ".sqlite"
            }
        }
        set(value){
            objc_setAssociatedObject(self, &databaseNameHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &managedObjectContextHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &persistentStoreCoordinatorHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open var modelName: String {
        get {
            if let model = objc_getAssociatedObject(self, &modelNameHandle) as? String {
                return model
            } else {
                return EZCoreDataManager.appName
            }
        }
        set(value) {
            objc_setAssociatedObject(self, &modelNameHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &managedObjectContextHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &persistentStoreCoordinatorHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open var managedObjectContext: NSManagedObjectContext {
        get {
            if let context = objc_getAssociatedObject(self, &managedObjectContextHandle) as? NSManagedObjectContext  {
                return context
            } else {
                let c = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
                c.persistentStoreCoordinator = persistentStoreCoordinator
                objc_setAssociatedObject(self, &managedObjectContextHandle, c, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return c
            }
        }
        set (value){
            objc_setAssociatedObject(self, &managedObjectContextHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        get {
            if let store = objc_getAssociatedObject(self, &persistentStoreCoordinatorHandle) as? NSPersistentStoreCoordinator  {
                return store
            } else {
                let p = self.persistentStoreCoordinator(NSSQLiteStoreType, storeURL: self.sqliteStoreURL)
                objc_setAssociatedObject(self, &persistentStoreCoordinatorHandle, p, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return p
            }
        }set(value){
            objc_setAssociatedObject(self, &persistentStoreCoordinatorHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open var managedObjectModel: NSManagedObjectModel {
        if let m = objc_getAssociatedObject(self, &managedObjectModelHandle) as? NSManagedObjectModel {
            return m
        } else {
            let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")
            let model = NSManagedObjectModel(contentsOf: modelURL!)
            objc_setAssociatedObject(self, &managedObjectModelHandle, model, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return model!
        }
    }
    
    open func useInMemoryStore() {
        persistentStoreCoordinator = self.persistentStoreCoordinator(NSInMemoryStoreType, storeURL: nil)
    }
    
    open func saveContext() -> Bool {
        return self.managedObjectContext.saveData()
    }
    
    fileprivate var sqliteStoreURL: URL {
        #if os(iOS)
            let dir = EZCoreDataManager.applicationDocumentsDirectory
            #else
            let dir = EZCoreDataManager.applicationSupportDirectory
            self.createApplicationSupportDirIfNeeded(dir)
        #endif
        return dir!.appendingPathComponent(self.databaseName)
        
    }
    
    fileprivate func persistentStoreCoordinator(_ storeType: String, storeURL: URL?) -> NSPersistentStoreCoordinator {
        let c = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let error: NSErrorPointer = nil
        do {
            try c.addPersistentStore(ofType: storeType, configurationName: nil, at: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true])
        } catch let error1 as NSError {
            error?.pointee = error1
            print("ERROR WHILE CREATING PERSISTENT STORE COORDINATOR! " + error.debugDescription)
        }
        return c
    }
    
    fileprivate static var applicationDocumentsDirectory:URL? {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last
    }
    
    fileprivate static var applicationSupportDirectory:URL? {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last?.appendingPathComponent(EZCoreDataManager.appName)
    }
    
    fileprivate static func createApplicationSupportDirIfNeeded(_ dir: URL) {
        if FileManager.default.fileExists(atPath: dir.absoluteString) {
            return
        }
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
    }
    // singleton
    open static let sharedManager = EZCoreDataManager()
}


public extension NSManagedObjectContext {
    
    public static var defaultContext: NSManagedObjectContext {
        return EZCoreDataManager.sharedManager.managedObjectContext
    }
    
    func createFetchRequest(_ entityName:String) -> NSFetchRequest<AnyObject> {
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entity(forEntityName: entityName, in: self)
        return request
    }
    
    func saveData() -> Bool {
        if !self.hasChanges {
            return true
        }
        let error: NSErrorPointer = nil
        let save: Bool
        do {
            try self.save()
            save = true
        } catch let error1 as NSError {
            error?.pointee = error1
            save = false
        }
        
        if (!save) {
            print("Unresolved error in saving context for entity:")
            print(self)
            print("!\nError: " + error.debugDescription)
            return false
        }
        return true
    }
}


public extension NSPredicate{
    
    public func condition(_ condition: AnyObject?) -> NSPredicate?{
        if let cond: AnyObject = condition {
            return NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates:[self, NSPredicate.predicate(cond)])
        }
        return self
    }
    
    public func orCondition(_ condition: AnyObject?) -> NSPredicate?{
        if let cond: AnyObject = condition {
            return NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates:[self, NSPredicate.predicate(cond)])
        }
        return self
    }
    
    fileprivate static func predicate(_ properties: [String:AnyObject]) -> NSPredicate {
        var preds = [NSPredicate]()
        for (key, value) in properties {
            preds.append(NSPredicate(format: "%K = %@", argumentArray: [key, value]))
        }
        return NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: preds)
    }
    
    fileprivate static func predicate(_ condition: AnyObject) -> NSPredicate {
        if condition is NSPredicate {
            return condition as! NSPredicate
        }
        if let d = condition as? [String:AnyObject] {
            return self.predicate(d)
        }
        return NSPredicate()
    }
}

public extension NSFetchRequest{
    
    public func condition(_ condition: AnyObject?) -> NSFetchRequest{
         if let cond: AnyObject = condition {
            if let pred = self.predicate {
                self.predicate = pred.condition(cond)
            }else{
                self.predicate = NSPredicate.predicate(cond)
            }
        }
        return self
    }
    
    public func orCondition(_ condition: AnyObject?) -> NSFetchRequest{
        if let cond: AnyObject = condition,let pred = self.predicate  {
            self.predicate = pred.orCondition(cond)
        }
        return self
    }
    
    public func orderBy(_ key:String,_ order:String = "ASC") -> NSFetchRequest{
        let sortDescriptor = NSSortDescriptor(key: key, ascending: order.uppercased()=="ASC")
        if self.sortDescriptors == nil{
            self.sortDescriptors = [sortDescriptor]
        }else{
            self.sortDescriptors?.append(sortDescriptor)
        }
        return self
    }
    
    /**
    * Set the "limit" value of the query.
    *
    * @param int value
    * @return self
    * @static
    */
    public func limit(_ value:Int) -> NSFetchRequest{
        self.fetchLimit = value
        self.fetchOffset = 0
        return self
    }
    
    /**
    * Alias to set the "limit" value of the query.
    *
    * @param int value
    * @return NSFetchRequest
    */
    public func take(_ value:Int) -> NSFetchRequest{
        return self.limit(value)
    }
    
    /**
    * Set the limit and offset for a given page.
    *
    * @param int page
    * @param int perPage
    * @return NSFetchRequest
    */
    public func forPage(_ page:Int,_ perPage:Int) -> NSFetchRequest{
        self.fetchLimit = perPage
        self.fetchOffset = (page - 1) * perPage
        return self
    }
    
    public func first() -> NSManagedObject?{
        return self.take(1).get().first
    }
    
    public func delete() -> NSInteger{
        var i = 0
        for o in self.get() {
            o.delete()
            i += 1
        }
        return i
    }
    
    public func get() -> [NSManagedObject]{
        return (try! NSManagedObjectContext.defaultContext.fetch(self)) as! [NSManagedObject] 
    }
    
    public func count() -> Int {
        return NSManagedObjectContext.defaultContext.count(for: self, error: nil)
    }
    
    public func exists() -> Bool {
        return self.count() > 0
    }
    
}


