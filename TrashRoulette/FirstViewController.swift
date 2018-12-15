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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		apollo.fetch(query: GetShowQuery(showID: 101165)) { result, _ in
			guard let data = result?.data else { return }
			self.showID.text = "\((data.media?.id)!)" // Force unwrap because swift is a bitch
			self.showTitle.text = data.media?.title?.romaji
			let imageURL = URL(string: (data.media?.coverImage?.large)!)
			self.showArt.setImage(url: imageURL!)
		}
	}
}
