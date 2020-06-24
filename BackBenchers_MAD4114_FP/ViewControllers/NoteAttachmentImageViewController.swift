//
//  NoteAttachmentImageViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-24.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class NoteAttachmentImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var imageData:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(data: imageData!)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
