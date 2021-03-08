//
//  CRole+CoreDataProperties.swift
//  
//
//  Created by Anggi Putra Gomis on 07/03/21.
//
//

import Foundation
import CoreData


extension CRole {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CRole> {
        return NSFetchRequest<CRole>(entityName: "CRole")
    }

    @NSManaged public var carry: String?
    @NSManaged public var disabler: String?
    @NSManaged public var durable: String?
    @NSManaged public var escape: String?
    @NSManaged public var initiator: String?
    @NSManaged public var jungler: String?
    @NSManaged public var nuker: String?
    @NSManaged public var pusher: String?
    @NSManaged public var support: String?
    @NSManaged public var hero: NSSet?

}

// MARK: Generated accessors for hero
extension CRole {

    @objc(addHeroObject:)
    @NSManaged public func addToHero(_ value: CHero)

    @objc(removeHeroObject:)
    @NSManaged public func removeFromHero(_ value: CHero)

    @objc(addHero:)
    @NSManaged public func addToHero(_ values: NSSet)

    @objc(removeHero:)
    @NSManaged public func removeFromHero(_ values: NSSet)

}
