//
//  CompetitionDetails.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/16/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class CompetitionDetails: UIViewController {

	@IBOutlet weak var labelCountryName: UILabel!
	@IBOutlet weak var compId: UILabel!
	@IBOutlet weak var numberOfSeason: UILabel!
	@IBOutlet weak var compPlan: UILabel!
	@IBOutlet weak var lastUpdated: UILabel!
	
	@IBOutlet weak var detailsScroll: UIScrollView!
	
	var countryName = ""
	var cName = ""
	var nSeasons = ""
	var cPlan = ""
	var cId = ""
	var lUpdated = ""

	override func viewDidLoad() {
        super.viewDidLoad()
		
		// managing scroll view
		detailsScroll.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)

		// updating details
		self.title = cName
		self.labelCountryName.text = countryName
		self.numberOfSeason.text = nSeasons
				self.lastUpdated.text = lUpdated
				self.compId.text = cId

    }
    



}
