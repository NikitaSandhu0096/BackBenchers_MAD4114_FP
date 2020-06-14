//
//  AppDelegate+Extension.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-14.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{
    static func getDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
}
