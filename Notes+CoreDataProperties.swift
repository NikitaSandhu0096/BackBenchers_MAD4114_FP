//
//  Notes+CoreDataProperties.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-13.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var data: String?
    @NSManaged public var subject: Subjects?

}
