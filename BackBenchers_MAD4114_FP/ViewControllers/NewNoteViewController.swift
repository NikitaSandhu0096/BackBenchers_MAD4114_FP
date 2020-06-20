//
//  NewNoteViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-13.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    let appDelegate = AppDelegate.getDelegate()
    var selectedSubject:Subjects?
    var selectedNote:Notes?
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteData: UITextView!
    
    func checkForCamera() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            let alertController = UIAlertController.init(title: nil, message: "No camera available.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteData.becomeFirstResponder()
        // Do any additional setup after loading the view.
        checkForCamera()
    }
    
    func createNewNote() {
        let newNote = Notes(context: appDelegate.persistentContainer.viewContext)
        newNote.title = noteTitle.text
        newNote.data = noteData.text
        newNote.timestamp = Date()
        newNote.subject = selectedSubject
        appDelegate.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let note = selectedNote{
            noteTitle.text = note.title
            noteData.text = note.data
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let note = selectedNote, let title = noteTitle.text, let data = noteData.text{
            note.title = title
            note.data = data
            note.timestamp = Date()
            appDelegate.saveContext()
        }
        else if selectedNote == nil{
            if !noteTitle.text!.isEmpty || !noteData.text!.isEmpty{
                createNewNote()
            }
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                
                alert.addAction(.init(title: "Take a Picture", style: .default, handler: { (action:UIAlertAction) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        let picker = UIImagePickerController()
                        picker.delegate = self
                        picker.sourceType = .camera
                        self.present(picker, animated: true, completion: nil)
                    }
                }))
                
                alert.addAction(.init(title: "Choose from Library", style: .default, handler: { (action:UIAlertAction) in
                    
                    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                        let picker = UIImagePickerController()
                        picker.sourceType = .savedPhotosAlbum
                        self.present(picker, animated: true, completion: nil)
                    }
                    
                }))
                
                alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addAudio(_ sender: UIButton) {
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

extension NewNoteViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
