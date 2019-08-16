//
//  ViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/8/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
	
	// defining views
	@IBOutlet weak var txtRegisterUsername: UITextField!
	@IBOutlet weak var btnRegister: UIButton!
	
	// the user's current pin
	private var pinToRegister: String = ""
	
	// 4 digits area views
	@IBOutlet weak var txtPIN1: UITextField!
	@IBOutlet weak var txtPIN2: UITextField!
	@IBOutlet weak var txtPIN3: UITextField!
	@IBOutlet weak var txtPIN4: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set title
		self.title = "Registartion"
		
		// hide keyboard on tap
		self.hideKeyboardWhenTappedAround()


		// setting up the 4 digits
		txtPIN1.delegate = self
		txtPIN2.delegate = self
		txtPIN3.delegate = self
		txtPIN4.delegate = self		
	}
	
	// managng textFields
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if ((textField.text?.count)! < 1 ) && (string.count > 0) {
			if textField == txtPIN1 {
				txtPIN2.becomeFirstResponder()
			}
			if textField == txtPIN2 {
				txtPIN3.becomeFirstResponder()
			}
			if textField == txtPIN3 {
				txtPIN4.becomeFirstResponder()
			}
			if textField == txtPIN4 {
				txtPIN4.resignFirstResponder()
			}
			textField.text = string
			return false
		} else if ((textField.text?.count)! >= 1) && (string.count == 0) {
			if textField == txtPIN2 {
				txtPIN1.becomeFirstResponder()
			}
			if textField == txtPIN3 {
				txtPIN2.becomeFirstResponder()
			}
			if textField == txtPIN4 {
				txtPIN3.becomeFirstResponder()
			}
			if textField == txtPIN1 {
				txtPIN1.resignFirstResponder()
			}
			
			textField.text = ""
			return false
		} else if (textField.text?.count)! >= 1 {
			textField.text = string
			return false
		}
		return true
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
		pinToRegister = txtPIN1.text! + txtPIN2.text! + txtPIN3.text! + txtPIN4.text!

		// save user credentials if if username is not empty and pin == 4 digits
		if txtRegisterUsername.text! != "" && pinToRegister.count == 4{

			// TODO better to save on keychain
			// saving users details in UserDefaults
			UserDefaults.standard.set(txtRegisterUsername.text!, forKey: "username")
			UserDefaults.standard.set(pinToRegister, forKey: "userPIN")

			// TODO use os_log() insead of print
			// take user to the login screen
			let loginVc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
			navigationController?.pushViewController(loginVc!, animated: true)
	
			print("user credentials registered in user defaults")
		}else {
			print("PIN length: \(pinToRegister.count)")
			// alert the user
			let wrongRegisterAlert = UIAlertController(title: "Register Failed ", message: "Please make sure username and 4 digits PIN are not empty.", preferredStyle: .alert)
			let okAction = UIAlertAction(title:"OK", style: .default, handler: nil)

			wrongRegisterAlert.addAction(okAction)
			present(wrongRegisterAlert, animated: true, completion: nil)

			// clear the pin text boxes
			// TODO find better ways to clear this
			txtPIN1.text = ""
			txtPIN2.text = ""
			txtPIN3.text = ""
			txtPIN4.text = ""
			
			// put the curson on the first box
			//txtPIN1.becomeFirstResponder()
		}
		
	}
	
}

