//
//  CompetitionCell.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/13/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class CompetitionCell: UITableViewCell {
	@IBOutlet weak var compCountryLabel: UILabel!
	@IBOutlet weak var compNameLabel: UILabel!
	@IBOutlet weak var compSeasonDateLable: UILabel!
	@IBOutlet weak var countryFlagImgView: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
