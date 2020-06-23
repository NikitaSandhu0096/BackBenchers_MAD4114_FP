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
    var searchedSubjects = [Subjects]()
    var isSearching = false
    
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
    
    func findSubject(subjectName:String) -> Subjects {
        let foundSubject = subjects.filter({
            $0.subjectName == subjectName
        })
        
        if !foundSubject.isEmpty{
            return foundSubject[0]
        }
        return Subjects()
    }
    
    @IBAction func shoppingClick(_ sender: UIButton) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        subjectNotesViewController.subject = findSubject(subjectName: "Shopping")
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
        
    }
    
    @IBAction func recipeClick(_ sender: UIButton) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        subjectNotesViewController.subject = findSubject(subjectName: "Reciepe")
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    

    @IBAction func groceryClick(_ sender: UIButton) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        subjectNotesViewController.subject = findSubject(subjectName: "Grocery")
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    
    @IBAction func todoClick(_ sender: UIButton) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        subjectNotesViewController.subject = findSubject(subjectName: "Todo")
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
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
        if isSearching
        {
            return searchedSubjects.count
        }
        else{
             return subjects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell")
        let subject:Subjects
        
        if isSearching {
            subject = searchedSubjects[indexPath.row]
        }
        else{
            subject = subjects[indexPath.row]
        }
        
        cell?.textLabel?.text = subject.subjectName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subjectNotesViewController = UIStoryboard.getViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        
        if isSearching{
            subjectNotesViewController.subject = searchedSubjects[indexPath.row]
        }
        else{
            subjectNotesViewController.subject = subjects[indexPath.row]
        }
        
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let subject:Subjects
            if isSearching {
                subject = searchedSubjects[indexPath.row]
            }
            else{
                subject = subjects[indexPath.row]
            }
            
            if  subject.subjectName! != "Shopping" && subject.subjectName! != "Reciepe" && subject.subjectName! != "Grocery" && subject.subjectName! != "Todo"{
                 Subjects.deleteSubject(s: subject)
                 reloadData()
            }
            else{
                let alert = UIAlertController(title: "Not Allowed", message: "Cannot delete this subject", preferredStyle: .alert)
                alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}


extension SubjectsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedSubjects = subjects.filter({
            return $0.subjectName!.lowercased().hasPrefix(searchText.lowercased())
        })
        isSearching = true
        tblSubjects.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        self.tblSubjects.reloadData()
    }
}
