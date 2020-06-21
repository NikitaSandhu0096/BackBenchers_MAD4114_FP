//
//  SubjectNotesViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-12.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class SubjectNotesViewController: UIViewController {

    @IBOutlet weak var tblSubjectNotes: UITableView!
    var subject:Subjects?
    var subjectNotes:[Notes] = [Notes]()
    var searchedNotes:[Notes] = [Notes]()
    var isSearching = false
    
    
    func reloadData() {
        subjectNotes = subject!.notes?.allObjects as! [Notes]
        tblSubjectNotes.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(subject?.subjectName ?? "Subject") Notes"
        self.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadData()
    }
    
    @IBAction func bbAddNewNote(_ sender: UIBarButtonItem) {
        let newNoteVC = UIStoryboard.getViewController(identifier: "NewNoteViewController") as! NewNoteViewController
        newNoteVC.selectedSubject = subject
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
    @IBAction func bbSort(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort", message: "Select an option to sort the notes", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Title", style: .default, handler: {(action) in
            
            self.subjectNotes = self.subjectNotes.sorted { (note1, note2) -> Bool in
                return note1.title!.lowercased() < note2.title!.lowercased()
            }
            self.tblSubjectNotes.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Date/Time", style: .default, handler: { (action) in
            self.subjectNotes = self.subjectNotes.sorted { (note1, note2) -> Bool in
                return note1.timestamp?.compare(note2.timestamp!) == ComparisonResult.orderedDescending
            }
            self.tblSubjectNotes.reloadData()
        }))
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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

extension SubjectNotesViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedNotes.count
        }
        else{
            return subject!.notes!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectNotesCell")
        var note:Notes
        
        if isSearching {
            note = searchedNotes[indexPath.row]
        }
        else{
            note = subjectNotes[indexPath.row]
        }
        print(note.lat, note.long)
        cell?.textLabel?.text = note.title!.isEmpty ? note.data : note.title
        cell?.detailTextLabel?.text = Date.getStringDate(dateFormate: "HH:mm E, d MMM y", date: note.timestamp!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newNoteVC = UIStoryboard.getViewController(identifier: "NewNoteViewController") as! NewNoteViewController
        newNoteVC.selectedSubject = subject
        if isSearching {
            newNoteVC.selectedNote = searchedNotes[indexPath.row]
        }
        else{
            newNoteVC.selectedNote = subjectNotes[indexPath.row]
        }
        newNoteVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let note = subjectNotes[indexPath.row]
            Notes.deleteNote(note: note)
            self.reloadData()
        }
    }
}

extension SubjectNotesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedNotes = self.subjectNotes.filter({
            return $0.title!.lowercased().hasPrefix(searchText.lowercased()) || $0.data!.lowercased().contains(searchText.lowercased())
        })
        isSearching = true
        tblSubjectNotes.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        self.tblSubjectNotes.reloadData()
    }
}
