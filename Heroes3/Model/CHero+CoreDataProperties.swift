//
//  CHero+CoreDataProperties.swift
//  
//
//  Created by Anggi Putra Gomis on 07/03/21.
//
//

import Foundation
import CoreData


extension CHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CHero> {
        return NSFetchRequest<CHero>(entityName: "CHero")
    }

    @NSManaged public var name: String?
    @NSManaged public var img: String?
    @NSManaged public var type: String?
    @NSManaged public var attribute: String?
    @NSManaged public var health: Int32
    @NSManaged public var mana: Int32
    @NSManaged public var minAttack: Int32
    @NSManaged public var maxAttack: Int32
    @NSManaged public var speed: Int32
    @NSManaged public var armor: Float
    @NSManaged public var id: Int32
    @NSManaged public var roles: NSSet?

}

// MARK: Generated accessors for roles
extension CHero {

    @objc(addRolesObject:)
    @NSManaged public func addToRoles(_ value: CRole)

    @objc(removeRolesObject:)
    @NSManaged public func removeFromRoles(_ value: CRole)

    @objc(addRoles:)
    @NSManaged public func addToRoles(_ values: NSSet)

    @objc(removeRoles:)
    @NSManaged public func removeFromRoles(_ values: NSSet)

}
