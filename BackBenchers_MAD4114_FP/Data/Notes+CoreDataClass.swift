//
//  Notes+CoreDataClass.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-14.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData


public class Notes: Subjects {
    
    func addAttachment(a:Attachment) {
        let images = self.mutableSetValue(forKey: "attachments")
        images.add(a)
    }
    
    func getAttachments() -> [Attachment]? {
        if let img = self.attachments{
            return img.allObjects as? [Attachment]
        }
        return nil
    }
    
    static func deleteNote(note:Notes){
        let dataManager = AppDelegate.getDelegate().persistentContainer.viewContext
        dataManager.delete(note)
    }
    
}
