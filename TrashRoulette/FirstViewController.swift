//
//  FirstViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
	@IBOutlet var showTitle: UILabel!
	@IBOutlet var showID: UILabel!
	@IBOutlet weak var showArt: UIImageView!
	@IBOutlet weak var searchField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
	}
	
	
	@IBAction func runSearch(_ sender: Any) {
		print("== Text Box: \(searchField.text!)")
		runQuery(genre: (searchField.text)!)
	}
	
	func runQuery(genre: String) {
		apollo.fetch(query: GetShowQuery(genre: genre)) { result, _ in
			guard let data = result?.data?.page?.media else { return }
			self.showID.text = "\((data[data.startIndex]?.title?.native)!)" // Force unwrap because swift is a bitch
			self.showTitle.text = data[data.startIndex]?.title?.romaji
			let imageURL = URL(string: (data[data.startIndex]?.coverImage?.extraLarge)!)
			self.showArt.setImage(url: imageURL!)
		}
	}
}

