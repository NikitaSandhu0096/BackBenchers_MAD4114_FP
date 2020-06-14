//
//  SecondViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-09.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit
import CoreData

class SubjectsViewController: UIViewController {
    
    @IBOutlet weak var tblSubjects: UITableView!
    let appDelegate = AppDelegate.getDelegate()
    var subjects = [Subjects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData() {
        if let data = Subjects.fetchData(){
            subjects = data
        }
        tblSubjects.reloadData();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        appDelegate.saveContext();
    }

    @IBAction func bbAdd(_ sender: UIBarButtonItem) {
        //https://stackoverflow.com/questions/31922349/how-to-add-textfield-to-uialertcontroller-in-swift/31922603
        let alert = UIAlertController(title: "New Subject", message: "Enter a subject name for this folder.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textSubject : UITextField!) -> Void in
            textSubject.placeholder = "Subject Name"
        }
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(.init(title: "Save", style: .default, handler: { (action) in
            Subjects.addSubject(subjectName: (alert.textFields?[0].text)!)
            self.reloadData()
        }))
        
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

extension SubjectsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell")
        cell?.textLabel?.text = subjects[indexPath.row].subjectName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        subjectNotesViewController.subjectNotes = subjects[indexPath.row].notes
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let subject = subjects[indexPath.row]
            Subjects.deleteSubject(s: subject)
            reloadData()
        }
        
    }
}
