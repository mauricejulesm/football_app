//
//  CompetitionsViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/8/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class CompetitionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableViewCompetitions: UITableView!
	@IBOutlet weak var searchBarView: UITableView!
	
	final let url = URL(string: "http://api.football-data.org/v2/competitions")
	private var competitions = [Competition]()
	
	//	let  cachedComptList = NSCache<NSString, NSArray>()
	
	// current row
	var rowIndext:Int  = 0
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Competitions List"
		
		// hide keyboard on tap
		self.hideKeyboardWhenTappedAround()
		
		//		let storedCompList =  cachedComptList.object(forKey: "competitions_list")
		
		
		
		// downloading the data when the view has loaded
		//		if storedCompList != nil && storedCompList!.count > 0{
		//			print("competitions list cache was found")
		//
		//			self.competitions = storedCompList as! [Competition]
		//			DispatchQueue.main.async {
		//				self.tableViewCompetitions.reloadData()
		//			}
		//
		//			// downloading the data when the view has loaded
		//		}else{
		//			downloadJson()
		//			print("competitions list  cache was not found downloading data now...")
		//		}
		
		// downloading the data when the view has loaded
		downloadJson()
		
		// removing empty rows
		tableViewCompetitions.tableFooterView = UIView()
		
		tableViewCompetitions.dataSource = self
		tableViewCompetitions.delegate = self
	}
	
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		// removing the top back button
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return competitions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell") as? CompetitionCell else{
			return UITableViewCell()
		}
		
		cell.labelCompCountry.text = "Country: \(competitions[indexPath.row].area.name)"
		cell.labelCompName.text = competitions[indexPath.row].name
		let fullDate = competitions[indexPath.row].lastUpdated
		let seasonDate = fullDate.components(separatedBy: "T")[0]
		cell.labelCompSeasonDate.text = "Date: \(seasonDate)"
		cell.countryFlagImgView.image = UIImage(named: "soccer-ball")
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("row number: \(indexPath.row)")
		self.rowIndext = indexPath.row
		performSegue(withIdentifier: "DetailsSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let cv = segue.destination as! CompetitionDetails
		cv.cName = competitions[rowIndext].name
		cv.lUpdated = "Last Updated : \(competitions[rowIndext].lastUpdated.components(separatedBy: "T")[0])"
		cv.cPlan = "Competition plan: \(competitions[rowIndext].plan)"
		cv.nSeasons = "Seasons : \(String(competitions[rowIndext].numberOfAvailableSeasons))"
		cv.countryName = "Country Name: \(competitions[rowIndext].area.name)"
		cv.cId = "Competition Id: \(String(competitions[rowIndext].area.id))"
	}
	
	
	@IBAction func onUserLogout(_ sender: Any) {
		
//		UserDefaults.standard.removeObject(forKey: "username")
		
		let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
		let navView = UINavigationController(rootViewController: vc!)
		let shared = UIApplication.shared.delegate as? AppDelegate
		shared?.window?.rootViewController = navView
		shared?.window?.makeKeyAndVisible()
		
		print("User logged out")
		
	}
	
	
	
	
	func downloadJson() {
		
		var request = URLRequest(url: url!)
		request.setValue("613f3a07fcce4ac9ae1dbaa022547005", forHTTPHeaderField: "X-Auth-Token")
		
		
		URLSession.shared.dataTask(with: request) { data, urlResponse, error in
			guard let data = data, error == nil, urlResponse != nil else {
				print("Something went wrong, couldn't fetch data!")
				return
			}
			print("Successfully fetched data")
			do
			{
				let decoder = JSONDecoder()
				let downloadedCompetitions = try decoder.decode(Competitions.self, from: data)
				
				self.competitions = downloadedCompetitions.competitions
				//				self.cachedComptList.setObject(downloadedCompetitions.competitions as NSArray, forKey: "competitions_list")
				
				DispatchQueue.main.async {
					self.tableViewCompetitions.reloadData()
				}
			} catch {
				print("something wrong after downloaded")
			}
			}.resume()
		
		//		UserDefaults.standard.set(self.competitions, forKey: "competitions_list")
	}
	
	
}
