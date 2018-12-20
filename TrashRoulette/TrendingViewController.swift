//
//  TrendingViewController.swift
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

class TrendingViewController: UITableViewController {
    
    /// Vars
    var data = [showData]()
    var tempShowData = showData()
//    let testArrayTitle = ["Test 1", "Test 2", "Test 3"]
//    let testArrayStudio = ["Studio 1", "Studio 2", "Studio 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grabPopularData()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("== Count: ", data.count)
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableCell", for: indexPath) as! TrendingTableViewCell
        
        cell.trendingTitleLabel.text = data[indexPath.row].title
        print("== Show Title: ", data[indexPath.row].title!)
        cell.trendingStudioLabel.text = data[indexPath.row].studio
        print("== Show Studio: ", data[indexPath.row].studio!)
        cell.trendingImageView.setImage(url: data[indexPath.row].imageURL!)
        
        return cell
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
            
            /// Get show title
            self.tempShowData.title = (index?.title?.romaji)!
            
            /// Get image
            self.tempShowData.imageURL = URL(string: (index?.coverImage?.extraLarge)!)!
            
            /// Store the results in the struct array
            self.data.append(tempShowData)
        }
        
        print(self.data)
        print(self.data.count)
        
        self.tableView.reloadData()
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
