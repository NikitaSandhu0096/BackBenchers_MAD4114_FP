//
//  Subjects+CoreDataClass.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-14.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//
//

import Foundation
import CoreData

public class Subjects: NSManagedObject {
    
    static func fetchData() -> [Subjects]? {
        let dataManager = AppDelegate.getDelegate().persistentContainer.viewContext
        do {
            if let result = try dataManager.fetch(Subjects.fetchRequest()) as? [Subjects]{
                return result
            }
        } catch  {
            print ("Error retrieving data")
        }
        return nil
    }
    
    
    static func addSubject(subjectName:String){
        let dataManager = AppDelegate.getDelegate().persistentContainer.viewContext
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: dataManager) as? Subjects
        newEntity?.subjectName = subjectName
    }
    
    static func deleteSubject(s:Subjects){
        let dataManager = AppDelegate.getDelegate().persistentContainer.viewContext
        dataManager.delete(s)
    }
}
