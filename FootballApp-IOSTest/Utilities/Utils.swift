//
//  Utils.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/16/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class Utils: NSObject {
}
	// Put this piece of code anywhere you like
	extension UIViewController {
		func hideKeyboardOnScreenTap() {
			let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
			tap.cancelsTouchesInView = false
			view.addGestureRecognizer(tap)
		}
		
		@objc func dismissKeyboard() {
			view.endEditing(true)
		}
	}

