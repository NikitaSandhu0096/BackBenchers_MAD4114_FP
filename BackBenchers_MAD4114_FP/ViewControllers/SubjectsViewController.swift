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
    @IBOutlet weak var tblNotes: UITableView!
    
    var dataManager : NSManagedObjectContext!
    var subjects = [Subjects]()
    
    func fetchSubjects()  {
        do {
            if let result = try dataManager.fetch(Subjects.fetchRequest()) as? [Subjects]{
                subjects = result
            }
        } catch  {
            print ("Error retrieving data")
        }
    }
    
    func addSubject(subjectName:String) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: dataManager) as? Subjects
        newEntity?.subjectName = subjectName

        do {
            try self.dataManager.save()
        } catch  {
            print ("Error saving data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        fetchSubjects()
    }

    @IBAction func bbAdd(_ sender: UIBarButtonItem) {
        
        //https://stackoverflow.com/questions/31922349/how-to-add-textfield-to-uialertcontroller-in-swift/31922603
        let alert = UIAlertController(title: "New Subject", message: "Enter a subject name for this folder.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textSubject : UITextField!) -> Void in
            textSubject.placeholder = "Subject Name"
        }
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(.init(title: "Save", style: .default, handler: { (action) in
            self.addSubject(subjectName: (alert.textFields?[0].text)!)
            self.fetchSubjects()
            self.tblNotes.reloadData()
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

extension NotesViewController : UITableViewDelegate, UITableViewDataSource{
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subjectNotesViewController = sb.instantiateViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    
}
