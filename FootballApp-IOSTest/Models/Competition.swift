//
//  Competition.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/13/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class Competitions: Codable {
	let competitions: [Competition]
	
	init(compContainer:[Competition]) {
		self.competitions = compContainer
	}
}

class Competition: Codable {
		let id: Int
		let name: String
		let lastUpdated: String

		init(id:Int,name:String, seasonDate:String) {
			self.id = id
			self.name = name
			self.lastUpdated = seasonDate
		}
}
