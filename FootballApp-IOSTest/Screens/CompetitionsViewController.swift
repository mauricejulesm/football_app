//
//  CompetitionsViewController.swift
//  FootballApp-IOSTest
//
//  Created by maurice on 8/8/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit

class CompetitionsViewController: UIViewController, UITableViewDataSource {
	
	@IBOutlet weak var tableViewCompetitions: UITableView!
	
	final let url = URL(string: "http://api.football-data.org/v2/competitions")
	private var competitions = [Competition]()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// downloading the data when the view has loaded
		downloadJson()
		
		// removing empty rows
		tableViewCompetitions.tableFooterView = UIView()
		
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
		
		cell.compCountryLabel.text = "Team Id: \(String(competitions[indexPath.row].id))"
		cell.compNameLabel.text = "Name: \(competitions[indexPath.row].name)"
		cell.compSeasonDateLable.text = "Date: \(competitions[indexPath.row].lastUpdated)"

		return cell
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
	
	
	
	
	func downloadJson() {
		guard let downloadURL = url else { return }
		URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
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
				DispatchQueue.main.async {
					self.tableViewCompetitions.reloadData()
				}
			} catch {
				print("something wrong after downloaded")
			}
			}.resume()
		
	}

	
}
