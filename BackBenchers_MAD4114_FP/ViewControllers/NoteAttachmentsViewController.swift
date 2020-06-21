//
//  NoteAttachmentsViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-20.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class NoteAttachmentsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var attachments:[Attachment]?
    var counter = 0
    
    func fillImage(c:Int) {
       if let atts = attachments{
            if c < atts.count {
                let imageData = atts[c].data
                if let imageData = imageData{
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillImage(c: counter)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        counter+=1
        if counter>=0 || counter < attachments!.count{
            fillImage(c: counter)
        }
        else{
            counter-=1
        }
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
       counter-=1
       if counter>=0 || counter < attachments!.count{
            fillImage(c: counter)
       }
       else{
        counter+=1
        }
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
