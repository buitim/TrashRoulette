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
        
        print("== Data Count: \(popularData.count)")
        if popularData.isEmpty {
            return 50
        } else {
            return popularData.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        
        let showData = popularData[indexPath.row]
        cell.trendingTitleLabel.text = showData.studio
        cell.trendingStudioLabel.text = showData.studio
        cell.trendingImageView.setImage(url: showData.imageURL!)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.grabPopularData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //        trendingTableView.delegate = self
        //        trendingTableView.dataSource = self
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
            print("== Show Title: \(String(describing: self.tempShowData.title))")
            
            // Get image
            self.tempShowData.imageURL = URL(string: (index?.coverImage?.extraLarge)!)!
            
            /// Store the results in the struct array
            popularData.append(tempShowData)
        }
    }
    
    fileprivate func showHUD(_ hud: JGProgressHUD) {
        hud.vibrancyEnabled = true
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 15
        hud.textLabel.text = "Taking out the trash..."
        hud.show(in: self.view)
    }
    
    func grabPopularData() {
        
        // Progress modal instance
        // Possible incorporate progress soon?
        let hud = JGProgressHUD(style: .dark)
        showHUD(hud)
        
        // Run Query
        apollo.fetch(query: GetPopularAiringShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
            
            // Dismiss HUD
            hud.dismiss()
            
            self.storeDataInArray(data) // Caius would be proud
            
        }
        
    }
    
}
