//
//  CompetitionsViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/8/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class CompetitionsViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		// removing the top back button
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
	}
	
	@IBAction func onUserLogout(_ sender: Any) {
		
		UserDefaults.standard.removeObject(forKey: "username")
		
		let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
		let navView = UINavigationController(rootViewController: vc!)
		let shared = UIApplication.shared.delegate as? AppDelegate
		shared?.window?.rootViewController = navView
		shared?.window?.makeKeyAndVisible()
		
		print("User logged out")
		
	}
	
}
