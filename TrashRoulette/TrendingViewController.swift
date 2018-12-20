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

//MARK: Definition for custom cell
class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendingTitleLabel: UILabel!
    @IBOutlet weak var trendingStudioLabel: UILabel!
    @IBOutlet weak var trendingImageView: UIImageView!
}

class TrendingViewController: UITableViewController {
    
    //MARK: Local Vars
    var data = [showData]()
    var tempShowData = showData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPopularData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableCell", for: indexPath) as! TrendingTableViewCell
        
        cell.trendingTitleLabel.text = data[indexPath.row].title
        cell.trendingStudioLabel.text = data[indexPath.row].studio
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
        
        //MARK: Reload the table after we finally grabbed all of the data
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
        
        //MARK: Progress modal instance
        let hud = JGProgressHUD(style: .dark)
        showHUD(hud)
        
        //MARK: Run Query
        apollo.fetch(query: GetPopularAiringShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
            
            //MARK: Dismiss HUD
            hud.dismiss()
            
            self.storeDataInArray(data) // Caius would be proud
            
        }
        
    }
    
}
