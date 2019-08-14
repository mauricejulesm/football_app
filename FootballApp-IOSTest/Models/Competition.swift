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
		let area: Area
		let name: String
//		let currentSeason: Season
		let lastUpdated :String
	

	init(area:Area, name:String, currentseason:Season, lastUpdated:String) {
			self.name = name
			self.area = area
//			self.currentSeason = currentseason
			self.lastUpdated = lastUpdated
		}
}

class Area: Codable {
	let name: String
	
	init(name:String) {
		self.name = name
	}
}

class Season: Codable {
	let id: Int
	let startDate: String
	let endDate: String

	init(id:Int, startDate:String, endDate:String) {
		self.id = id
		self.startDate = startDate
		self.endDate = endDate
	}
}
