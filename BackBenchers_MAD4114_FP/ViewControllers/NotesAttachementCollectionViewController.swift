//
//  NotesAttachementCollectionViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Kashyap Jhaveri on 2020-06-20.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit



class NotesAttachementCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    var attachments:[Attachment]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let count = attachments?.count{
            print(count)
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let attachment = attachments![indexPath.row]
        
        if let imageData = attachment.data{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteAttachmentPhotoCollectionViewCell", for: indexPath) as! NoteAttachmentPhotoCollectionViewCell
            let imageData = imageData
            cell.image.image = UIImage(data: imageData)
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteAttachmentAudioCollectionViewCell", for: indexPath) as! NoteAttachmentAudioCollectionViewCell
            
            cell.audioFileTitle.text = Date.getStringDate(dateFormate: "HH:mm E, d MMM y", date: attachment.timeStamp!)
            
            return cell
        }
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let attachment = attachments![indexPath.row]
        
        if let imageData = attachment.data{
            let NoteAttachmentImageVC = UIStoryboard.getViewController(identifier: "NoteAttachmentImageViewController") as! NoteAttachmentImageViewController
            NoteAttachmentImageVC.imageData = imageData
            self.present(NoteAttachmentImageVC, animated: true, completion: nil)
        }
        else{
            
            let NoteAttachmentAudioVC = UIStoryboard.getViewController(identifier: "NoteAttachmentAudioViewController") as! NoteAttachmentAudioViewController
            NoteAttachmentAudioVC.attachment = attachment
            self.present(NoteAttachmentAudioVC, animated: true, completion: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
    

}
