//
//  Subjects+CoreDataProperties.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-13.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subject")
    }

    @NSManaged public var subjectName: String?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notess
extension Subjects {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Notes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Notes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
