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
//        let bbAddVehicleRent = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
//        navigationItem.leftBarButtonItem = bbAddVehicleRent

        // Do any additional setup after loading the view.
    }
//
//    @objc func logout(){
//        self.navigationController?.popViewController(animated: true)
//    }

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
        cell?.textLabel?.text = ""
        return cell!
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    
}
