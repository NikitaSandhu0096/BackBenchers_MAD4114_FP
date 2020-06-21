//
//  Notes+CoreDataProperties.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-21.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    static func fetchRequest() -> NSFetchRequest<Notes> {
        let request = NSFetchRequest<Notes>(entityName: "Note")
        request.includesSubentities = false
        return request
    }

    @NSManaged public var data: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var subject: Subjects?
    @NSManaged public var attachments: NSSet?

}

// MARK: Generated accessors for attachments
extension Notes {

    @objc(addAttachmentsObject:)
    @NSManaged public func addToAttachments(_ value: Attachment)

    @objc(removeAttachmentsObject:)
    @NSManaged public func removeFromAttachments(_ value: Attachment)

    @objc(addAttachments:)
    @NSManaged public func addToAttachments(_ values: NSSet)

    @objc(removeAttachments:)
    @NSManaged public func removeFromAttachments(_ values: NSSet)

}
