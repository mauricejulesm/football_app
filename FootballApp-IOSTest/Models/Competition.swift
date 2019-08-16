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
	let plan: String
	let numberOfAvailableSeasons: Int
	//		let currentSeason: Season
	let lastUpdated :String
	
	
	init(area:Area, name:String, currentseason:Season, lastUpdated:String, plan:String, nS:Int) {
		self.name = name
		self.area = area
		self.plan = plan
		self.numberOfAvailableSeasons = nS
		//			self.currentSeason = currentseason
		self.lastUpdated = lastUpdated
	}
}

class Area: Codable {
	let id:Int
	let name: String
	
	init(name:String, id:Int) {
		self.name = name
		self.id = id
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
