//
//  Date=Extension.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-17.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import Foundation


extension Date{
    
    static func getStringDate(dateFormate:String, date:Date) -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormate
        return dateFormater.string(from: date)
    }
}
