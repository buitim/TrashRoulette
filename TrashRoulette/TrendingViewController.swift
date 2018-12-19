//
//  SecondViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD

struct showData {
    var imageURL: URL?
    var title: String?
    var studio: String?
    
}

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendingTitleLabel: UILabel!
    @IBOutlet weak var trendingStudioLabel: UILabel!
    @IBOutlet weak var trendingImageView: UIImageView!
}

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// Vars
    @IBOutlet weak var trendingTableView: UITableView!
    var popularData = [showData]()
    var tempShowData = showData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
        
        cell.trendingTitleLabel.text = "Lorem"
        cell.trendingStudioLabel.text = "Ipsum"
        //        cell.trendingImageView.image
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }
    
    
    fileprivate func storeDataInArray(_ data: [GetPopularAiringShowsQuery.Data.Page.Medium?]) {
        for index in data
        {
            let getStudioNameHelper = index?.studios?.nodes
            
            if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
                self.tempShowData.studio = (getStudioNameHelper?[0]?.name)!
            } else {
                self.tempShowData.studio = "Unknown Studio"
            }
            
            // Get show title
            self.tempShowData.title = (index?.title?.romaji)!
            
            // Get image
            self.tempShowData.imageURL = URL(string: (index?.coverImage?.extraLarge)!)!
        }
    }
    
    func grabPopular() {
        
        // Progress modal instance
        // Possible incorporate progress soon?
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 15
        hud.textLabel.text = "Taking out the trash..."
        hud.show(in: self.view)
        
        // Run Query
        apollo.fetch(query: GetPopularAiringShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
            
            // Dismiss HUD
            hud.dismiss()
            
            self.storeDataInArray(data) // Caius would be proud
            
        }
    }
        
}
