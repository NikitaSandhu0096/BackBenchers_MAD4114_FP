//
//  UIStoryboard+Extension.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-14.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    static func getViewController(identifier:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil);
        return storyBoard.instantiateViewController(identifier: identifier);
    }
    
}
