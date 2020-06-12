//
//  SecondViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-09.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var tblNotes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func bbAdd(_ sender: UIBarButtonItem) {
        
//        https://stackoverflow.com/questions/31922349/how-to-add-textfield-to-uialertcontroller-in-swift/31922603
        let alert = UIAlertController(title: "New Subject", message: "Enter a subject name for this folder.", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textSubject : UITextField!) -> Void in
        textSubject.placeholder = "Subject Name"
        }
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(.init(title: "Save", style: .default, handler: nil))
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell")
        cell?.textLabel?.text = "Subject Name"
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subjectNotesViewController = sb.instantiateViewController(identifier: "SubjectNotesViewController") as! SubjectNotesViewController
        self.navigationController?.pushViewController(subjectNotesViewController, animated: true)
    }
    
    
    
}
