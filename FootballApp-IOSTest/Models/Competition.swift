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
		let currentSeason: Season
	let lastUpdated :String
	

	init(name:String, area:Area, currentSeason:Season, lastUpdated:String) {
			self.name = name
			self.area = area
			self.currentSeason = currentSeason
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
	let startDate: Date
	let endDate: Date

	init(startDate:Date, endDate:Date) {
		self.startDate = startDate
		self.endDate = endDate
	}
}
