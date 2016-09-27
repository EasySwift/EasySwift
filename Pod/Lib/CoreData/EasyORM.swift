//
//  NSManagedObject+EZExtend.swift
//  medical
//
//  Created by zhuchao on 15/5/30.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation
import CoreData

public func DBQuery(_ aClass: NSManagedObject.Type!,entityName:String) -> NSFetchRequest<AnyObject> {
    return aClass.defaultContext().createFetchRequest(entityName)
}

open class EasyORM {
    
    open static var generateRelationships = false
    
    open static func setUpEntities(_ entities: [String:NSManagedObject.Type]) {
        nameToEntities = entities
    }
    
    fileprivate static var nameToEntities: [String:NSManagedObject.Type] = [String:NSManagedObject.Type]()

    
}

public extension NSManagedObject{

    public func defaultContext() -> NSManagedObjectContext{
        return self.managedObjectContext ?? type(of: self).defaultContext()
    }
    
    public static func defaultContext() -> NSManagedObjectContext{
        return NSManagedObjectContext.defaultContext
    }
    
    fileprivate static var query:NSFetchRequest<AnyObject>{
        return self.defaultContext().createFetchRequest(self.entityName())
    }
    
    public static func condition(_ condition: AnyObject?) -> NSFetchRequest<AnyObject>{
        return self.query.condition(condition)
    }
    
    public static func orderBy(_ key:String,_ order:String = "ASC") -> NSFetchRequest<AnyObject>{
        return self.query.orderBy(key, order)
    }
    
    /**
    * Set the "limit" value of the query.
    *
    * @param int value
    * @return self
    * @static
    */
    public static func limit(_ value:Int) -> NSFetchRequest<AnyObject>{
        return self.query.limit(value)
    }
    
    /**
    * Alias to set the "limit" value of the query.
    *
    * @param int value
    * @return NSFetchRequest
    */
    public static func take(_ value:Int) -> NSFetchRequest<AnyObject>{
        return self.query.take(value)
    }
    
    /**
    * Set the limit and offset for a given page.
    *
    * @param int page
    * @param int perPage
    * @return NSFetchRequest
    */
    public static func forPage(_ page:Int,_ perPage:Int) -> NSFetchRequest<AnyObject>{
        return self.query.forPage(page,perPage)
    }
    
    public static func all() -> [NSManagedObject] {
        return self.query.get()
    }
    
    public static func count() -> Int {
        return self.query.count()
    }
    
    public static func findAndUpdate(_ unique:[String:AnyObject],data:[String:AnyObject]) -> NSManagedObject?{
        if let object = self.find(unique as AnyObject) {
            object.update(data)
            return object
        }else{
            return nil
        }
    }
    
    public static func updateOrCreate(_ unique:[String:AnyObject],data:[String:AnyObject]) -> NSManagedObject{
        if let object = self.find(unique as AnyObject) {
            object.update(data)
            return object
        }else{
            return self.create(data)
        }
    }
    
    public static func findOrCreate(_ properties: [String:AnyObject]) -> NSManagedObject {
        let transformed = self.transformProperties(properties)
        let existing = self.find(properties as AnyObject)
        return existing ?? self.create(transformed)
    }
    
    public static func find(_ condition: AnyObject) -> NSManagedObject? {
        return self.query.condition(condition).first()
    }
    
    public func update(_ properties: [String:AnyObject]) {
        
        if (properties.count == 0) {
            return
        }
        let transformed = type(of: self).transformProperties(properties)
        //Finish
        for (key, value) in transformed {
            self.willChangeValue(forKey: key)
            self.setSafeValue(value, forKey: key)
            self.didChangeValue(forKey: key)
        }
    }
    
    public func save() -> Bool {
        return self.defaultContext().saveData()
    }
    
    public func delete() -> NSManagedObjectContext {
        let context = self.defaultContext()
        context.delete(self)
        return context
    }
    
    public static func deleteAll() -> NSManagedObjectContext{
        for o in self.all() {
            o.delete()
        }
        return self.defaultContext()
    }
    
    public static func create() -> NSManagedObject {
        let o = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: self.defaultContext())
        if let idprop = self.autoIncrementingId() {
            o.setPrimitiveValue(NSNumber(value: self.nextId() as Int), forKey: idprop)
        }
        return o
    }
    
    public static func create(_ properties: [String:AnyObject]) -> NSManagedObject {
        let newEntity: NSManagedObject = self.create()
        newEntity.update(properties)
        if let idprop = self.autoIncrementingId() {
            if newEntity.primitiveValue(forKey: idprop) == nil {
                newEntity.setPrimitiveValue(NSNumber(value: self.nextId() as Int), forKey: idprop)
            }
        }
        return newEntity
    }
    
    public static func autoIncrements() -> Bool {
        return self.autoIncrementingId() != nil
    }
    
    public static func nextId() -> Int {
        let key = "SwiftRecord-" + self.entityName() + "-ID"
        if self.autoIncrementingId() != nil {
            let id = UserDefaults.standard.integer(forKey: key)
            UserDefaults.standard.set(id + 1, forKey: key)
            return id
        }
        return 0
    }
    

    public class func autoIncrementingId() -> String? {
        return nil
    }
    
    //Private
    
    fileprivate static func transformProperties(_ properties: [String:AnyObject]) -> [String:AnyObject]{
        let entity = NSEntityDescription.entity(forEntityName: self.entityName(), in: self.defaultContext())!
        let attrs = entity.attributesByName
        let rels = entity.relationshipsByName
        
        var transformed = [String:AnyObject]()
        for (key, value) in properties {
            let localKey = self.keyForRemoteKey(key)
            if attrs[localKey] != nil {
                transformed[localKey] = value
            } else if let rel = rels[localKey]  {
                if EasyORM.generateRelationships {
                    if rel.isToMany {
                        if let array = value as? [[String:AnyObject]] {
                            transformed[localKey] = self.generateSet(rel, array: array)
                        } else {
                            #if DEBUG
                                println("Invalid value for relationship generation in \(NSStringFromClass(self)).\(localKey)")
                                println(value)
                            #endif
                        }
                    } else if let dict = value as? [String:AnyObject] {
                        transformed[localKey] = self.generateObject(rel, dict: dict)
                    } else {
                        #if DEBUG
                            println("Invalid value for relationship generation in \(NSStringFromClass(self)).\(localKey)")
                            println(value)
                        #endif
                    }
                }
            }
        }
        return transformed
    }
    
    
    fileprivate func setSafeValue(_ value: AnyObject?, forKey key: String) {
        if (value == nil) {
            self.setNilValueForKey(key)
            return
        }
        let val: AnyObject = value!
        if let attr = self.entity.attributesByName[key] {
            let attrType = attr.attributeType
            if attrType == NSAttributeType.stringAttributeType && value is NSNumber {
                self.setPrimitiveValue((val as! NSNumber).stringValue, forKey: key)
            } else if let s = val as? String {
                if self.isIntegerAttributeType(attrType) {
                    self.setPrimitiveValue(NSNumber(value: val.intValue as Int), forKey: key)
                    return
                } else if attrType == NSAttributeType.booleanAttributeType {
                    self.setPrimitiveValue(NSNumber(value: val.boolValue as Bool), forKey: key)
                    return
                } else if (attrType == NSAttributeType.floatAttributeType) {
                    self.setPrimitiveValue(NSNumber(floatLiteral: val.doubleValue), forKey: key)
                    return
                } else if (attrType == NSAttributeType.dateAttributeType) {
                    self.setPrimitiveValue(type(of: self).dateFormatter.date(from: s), forKey: key)
                    return
                }
            }
        }
        self.setPrimitiveValue(value, forKey: key)
    }
    
    fileprivate func isIntegerAttributeType(_ attrType: NSAttributeType) -> Bool {
        return attrType == NSAttributeType.integer16AttributeType || attrType == NSAttributeType.integer32AttributeType || attrType == NSAttributeType.integer64AttributeType
    }
    
    fileprivate static var dateFormatter: DateFormatter {
        if _dateFormatter == nil {
            _dateFormatter = DateFormatter()
            _dateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        }
        return _dateFormatter!
    }
    fileprivate static var _dateFormatter: DateFormatter?
    
    
    public class func mappings() -> [String:String] {
        return [String:String]()
    }
    
    public static func keyForRemoteKey(_ remote: String) -> String {
        if let s = cachedMappings[remote] {
            return s
        }
        let entity = NSEntityDescription.entity(forEntityName: self.entityName(), in: self.defaultContext())!
        let properties = entity.propertiesByName
        if properties[remote] != nil {
            _cachedMappings![remote] = remote
            return remote
        }
        
        let camelCased = remote.camelCase
        if properties[camelCased] != nil {
            _cachedMappings![remote] = camelCased
            return camelCased
        }
        _cachedMappings![remote] = remote
        return remote
    }
    fileprivate static var cachedMappings: [String:String] {
        if let m = _cachedMappings {
            return m
        } else {
            var m = [String:String]()
            for (key, value) in mappings() {
                m[value] = key
            }
            _cachedMappings = m
            return m
        }
    }
    fileprivate static var _cachedMappings: [String:String]?
    
    fileprivate static func generateSet(_ rel: NSRelationshipDescription, array: [[String:AnyObject]]) -> NSSet {
        var cls: NSManagedObject.Type?
        if EasyORM.nameToEntities.count > 0 {
            cls = EasyORM.nameToEntities[rel.destinationEntity!.managedObjectClassName]
        }
        if cls == nil {
            cls = (NSClassFromString(rel.destinationEntity!.managedObjectClassName) as! NSManagedObject.Type)
        } else {
            print("Got class name from entity setup")
        }
        let set = NSMutableSet()
        for d in array {
            set.add(cls!.findOrCreate(d))
        }
        return set
    }
    
    fileprivate static func generateObject(_ rel: NSRelationshipDescription, dict: [String:AnyObject]) -> NSManagedObject {
        let entity = rel.destinationEntity!
        
        let cls: NSManagedObject.Type = NSClassFromString(entity.managedObjectClassName) as! NSManagedObject.Type
        return cls.findOrCreate(dict)
    }
    
    public static func primaryKey() -> String {
        NSException(name: "Primary key undefined in " + NSStringFromClass(self), reason: "Override primaryKey if you want to support automatic creation, otherwise disable this feature", userInfo: nil).raise()
        return ""
    }
    
    fileprivate static func entityName() -> String {
        var name = NSStringFromClass(self)
        if name.range(of: ".") != nil {
            let comp = name.characters.split {$0 == "."}.map { String($0) }
            if comp.count > 1 {
                name = comp.last!
            }
        }
        if name.range(of: "_") != nil {
            var comp = name.characters.split {$0 == "_"}.map { String($0) }
            var last: String = ""
            var remove = -1
            for (i,s) in Array(comp.reversed()).enumerated() {
                if last == s {
                    remove = i
                }
                last = s
            }
            if remove > -1 {
                comp.remove(at: remove)
                name = comp.joined(separator: "_")
            }
        }
        return name
    }
}

public extension String {
    var camelCase: String {
        let spaced = self.replacingOccurrences(of: "_", with: " ", options: [], range:(self.characters.indices))
        let capitalized = spaced.capitalized
        let spaceless = capitalized.replacingOccurrences(of: " ", with: "", options:[], range:(self.characters.indices))
        return spaceless.replacingCharacters(in: (spaceless.startIndex ..< spaceless.characters.index(after: spaceless.startIndex)), with: "\(spaceless[spaceless.startIndex])".lowercased())
    }
}
