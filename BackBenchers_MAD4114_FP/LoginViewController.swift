//
//  ViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-08.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUserID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var swhRememberMe: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if swhRememberMe.isOn != true{
            txtUserID.text = ""
            txtPassword.text = ""
        }
    }

    @IBAction func bbLogin(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let customerListVC = sb.instantiateViewController(identifier: "NotesViewController") as! NotesViewController
        self.navigationController?.pushViewController(customerListVC, animated: true)
    }
}

