//
//  LoginViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/9/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	// defining views
	@IBOutlet weak var txtLoginUsername: UITextField!
	@IBOutlet weak var txtLoginPin: UITextField!
	@IBOutlet weak var btnLogin: UIButton!
	
	// defining constants for user credentials
	let userName = "maurice"
	let userPIN = "1111"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	override func viewWillAppear(_ animated: Bool) {
		
		// making sure the back doesn't show
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
	}
	
	
	// Action to control what happens when the user presses the register btn
	@IBAction func onUserLogin(_ sender: Any) {
		if userName == txtLoginUsername.text! && userPIN == txtLoginPin.text! {
			
			// TODO try getting the users' info from the ones saved in the app and compare with those
			
			// TODO use os_log() insead of print
			// take user to the competitions screen
			let loginVc = storyboard?.instantiateViewController(withIdentifier: "CompetitionsViewController")
			navigationController?.pushViewController(loginVc!, animated: true)
			
			print("user authenticated")
			
		}else{
			// alert the user
			let wrongLoginAlert = UIAlertController(title: "Error", message: "username or pin is wrong", preferredStyle: .alert)
			let okAction = UIAlertAction(title:"Try Again", style: .default, handler: nil)
			
			wrongLoginAlert.addAction(okAction)
			present(wrongLoginAlert, animated: true, completion: nil)
			
			// clear the pin text
			// TODO find better ways to clear this
			txtLoginPin.text = ""
			
		}
		
	}
	
	
}
