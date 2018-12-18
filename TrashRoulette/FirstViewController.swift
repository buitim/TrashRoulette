//
//  FirstViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD

class FirstViewController: UIViewController {
	@IBOutlet var showTitle: UILabel!
	@IBOutlet var showID: UILabel!
	@IBOutlet weak var showArt: UIImageView!
	@IBOutlet weak var searchField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
	}
	
	
    @IBAction func randomShowAction(_ sender: Any) {
        runQuery(genre: "Action")
    }
    
    @IBAction func randomShowRomance(_ sender: Any) {
        runQuery(genre: "Romance")
    }
    
    @IBAction func randomShowComedy(_ sender: Any) {
        runQuery(genre: "Comedy")
    }
	
	func runQuery(genre: String) {
        // Progress modal instance
        // Possible incorporate progress soon?
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 20
        hud.textLabel.text = "Loading shows..."
        hud.show(in: self.view)
        
		apollo.fetch(query: GetShowQuery(genre: genre)) { result, _ in
			guard let data = result?.data?.page?.media else { return }
            hud.dismiss()
			let randomIndex = arc4random_uniform(UInt32(data.count))
			print("== Random Index: \(randomIndex)")

			
            // Check for nil value here
			self.showID.text = "\((data[data.index(Int(randomIndex), offsetBy:0)]?.title?.native)!)" // Force unwrap because swift is a bitch
			self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
			let imageURL = URL(string: (data[data.index(Int(randomIndex), offsetBy:0)]?.coverImage?.extraLarge)!)
			self.showArt.setImage(url: imageURL!)
		}
	}
}

