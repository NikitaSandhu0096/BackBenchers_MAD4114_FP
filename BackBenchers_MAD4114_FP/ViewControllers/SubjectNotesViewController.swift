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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bbAddNewNote(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let newNoteVC = sb.instantiateViewController(identifier: "NewNoteViewController") as! NewNoteViewController
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
    @IBAction func bbSort(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort", message: "Select an option to sort the notes", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Title", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Date/Time", style: .default, handler: nil))
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectNotesCell")
        cell?.textLabel?.text = "Subject note"
        return cell!
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
}

