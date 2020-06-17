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
    static func deleteNote(note:Notes){
        let dataManager = AppDelegate.getDelegate().persistentContainer.viewContext
        dataManager.delete(note)
    }
    
}
