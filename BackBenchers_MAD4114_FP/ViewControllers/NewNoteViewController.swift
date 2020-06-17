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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteData.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
