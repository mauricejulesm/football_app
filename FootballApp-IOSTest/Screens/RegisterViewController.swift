//
//  ViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/8/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	
	// defining views
	@IBOutlet weak var txtRegisterUsername: UITextField!
	@IBOutlet weak var txtRegisterPin: UITextField!
	@IBOutlet weak var btnRegister: UIButton!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		// hiding the navigation bar on the login screen
		navigationController?.isNavigationBarHidden = true
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		
		// making the nav controller visible when the user leaves the login page
		navigationController?.isNavigationBarHidden = false
	}
	
	// Action to control what happens when the user presses the register btn
	@IBAction func onUserRegister(_ sender: Any) {
		if txtRegisterUsername.text! != "" && txtRegisterPin.text!  != ""{
			
			// saving users details in UserDefaults
			UserDefaults.standard.set(txtRegisterUsername.text!, forKey: "username")
			
			// TODO use os_log() insead of print
			// take user to the login screen
			let loginVc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
			navigationController?.pushViewController(loginVc!, animated: true)
			
			print("user credentials registered in user defaults")
	}else{
	// alert the user
	let wrongRegisterAlert = UIAlertController(title: "Error", message: "Please make sure username and pin are not empty.", preferredStyle: .alert)
	let okAction = UIAlertAction(title:"OK", style: .default, handler: nil)
	
	wrongRegisterAlert.addAction(okAction)
	present(wrongRegisterAlert, animated: true, completion: nil)
	
	// clear the pin text
	// TODO find better ways to clear this
	txtRegisterPin.text = ""
	
	}
	
}

}

