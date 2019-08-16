//
//  LoginViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/9/19.
//  Copyright © 2019 maurice. All rights reserved.
//
import LocalAuthentication
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
	// defining views
	@IBOutlet weak var txtLoginUsername: UITextField!
	@IBOutlet weak var btnLogin: UIButton!
	
	
	// 4 digits area views
	@IBOutlet weak var txtPIN1: UITextField!
	@IBOutlet weak var txtPIN2: UITextField!
	@IBOutlet weak var txtPIN3: UITextField!
	@IBOutlet weak var txtPIN4: UITextField!
	
	
	
	// defining constants for user credentials from userdefaults
	let userName =  UserDefaults.standard.string(forKey: "username")
	let userPIN =  UserDefaults.standard.string(forKey: "userPIN")
	
	// the user's current pin
	private var currentPIN: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set Title
		self.title = "Login Page"
		
		// hide keyboard on tap
		self.hideKeyboardOnScreenTap()

		txtPIN1.delegate = self
		txtPIN2.delegate = self
		txtPIN3.delegate = self
		txtPIN4.delegate = self
		
		//		txtPIN1.becomeFirstResponder()
		
	}
	
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
			
			textField.text! = ""
			return false
		} else if (textField.text?.count)! >= 1 {
			textField.text = string
			return false
		}
		
		return true
	}
	
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		// making sure the back doesn't show
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
		
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// check for biometrics
		authenticateWithBiometrics()
	}
	
	// Action to control what happens when the user presses the register btn
	@IBAction func onUserLogin(_ sender: Any) {
		currentPIN = txtPIN1.text! + txtPIN2.text! + txtPIN3.text! + txtPIN4.text!
		// check if the user has entered 4 digits
		if currentPIN.count < 4 {
			//alert the user
			print("PIN length: \(currentPIN.count)")
			let pinAlert = UIAlertController(title: "Wrong PIN", message: "Please provide a 4 digits PIN", preferredStyle: .alert)
			let okAction = UIAlertAction(title:"Try Again", style: .default, handler: nil)
			
			pinAlert.addAction(okAction)
			present(pinAlert, animated: true, completion: nil)
			
			// clear the pin text boxes
			emptyPinBoxes()
			
		}else if txtLoginUsername.text! == userName && currentPIN == userPIN {
			// TODO use os_log() insead of print
			// take user to the competitions screen
			showCompetitionsList()
			
			print("user authenticated")
			
		}else{
			// alert the user
			let wrongLoginAlert = UIAlertController(title: "Login Failed", message: "username or pin is wrong", preferredStyle: .alert)
			let okAction = UIAlertAction(title:"Try Again", style: .default, handler: nil)
			
			wrongLoginAlert.addAction(okAction)
			present(wrongLoginAlert, animated: true, completion: nil)
			
			txtLoginUsername.becomeFirstResponder()
			// clear the pin text boxes
			emptyPinBoxes()
		}
		
	}
	
	func emptyPinBoxes() {
		// TODO find better ways to clear this
		txtPIN1.text = ""
		txtPIN2.text = ""
		txtPIN3.text = ""
		txtPIN4.text = ""
	}
	
	func authenticateWithBiometrics() {
		let context = LAContext()
		var myError: NSError?
		
		if context.canEvaluatePolicy(
			.deviceOwnerAuthenticationWithBiometrics, error: &myError) {
			
			// the device can use biometrics
			let reason = "Authenticate"
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
				DispatchQueue.main.async {
					if success {
						// load competition screen
						self?.showCompetitionsList()
						print("Successfully authenticated using biometric!")
					}else{
						// error occured while trying to authenticate
						let ac = UIAlertController(title: "Biometry Failed !", message: "Couldn't authenticate, please enter your credentials to login.", preferredStyle: .alert)
						ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
						self?.present(ac, animated:true)
					}
				}
			}
		}else {
			// the device doesn't support biometrics authentication
			let ac = UIAlertController(title: "Biometry not supported", message: "Your decive does not support biometric auntentication", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			present(ac, animated:true)
		}
	}
	
	func showCompetitionsList() {
		let loginVc = storyboard?.instantiateViewController(withIdentifier: "CompetitionsViewController")
		navigationController?.pushViewController(loginVc!, animated: true)
	}
}
