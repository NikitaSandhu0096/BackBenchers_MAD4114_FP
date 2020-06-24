//
//  Attachment+CoreDataProperties.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-24.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData


extension Attachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attachment> {
        return NSFetchRequest<Attachment>(entityName: "Attachment")
    }

    @NSManaged public var data: Data?
    @NSManaged public var filePath: URL?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var note: Notes?

}
