//
//  TrendingViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD
import GoogleMobileAds

struct showData {
    var imageURL: URL?
    var title: String?
    var rating: String?
    
}

//MARK: Definition for custom cell
class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendingTitleLabel: UILabel!
    @IBOutlet weak var trendingRatingLabel: UILabel!
    @IBOutlet weak var trendingImageView: UIImageView!
}

class TrendingViewController: UITableViewController, GADBannerViewDelegate {
    
    //MARK: Local Vars
    var data = [showData]()
    var tempShowData = showData()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        let request = GADRequest()
        request.testDevices = [ "6897da95070b60bbb1c8caab4aead016" ] // Used for testing ads
        bannerView.load(request)
        bannerView.delegate = self
        
        grabPopularData()
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }
    
    // MARK: - view positioning
    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: bottomLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableCell", for: indexPath) as! TrendingTableViewCell
        
        cell.trendingTitleLabel.text = data[indexPath.row].title
        cell.trendingRatingLabel.text = data[indexPath.row].rating
        cell.trendingImageView.setImage(url: data[indexPath.row].imageURL!)
        cell.trendingImageView.layer.cornerRadius = 7
        
        return cell
    }
    
    
    fileprivate func storeDataInArray(_ data: [GetPopularReleasingShowsQuery.Data.Page.Medium?]) {
        for index in data
        {
            
            // Get show rating
            var averageScoreDisplayText:String
            let averageScoreHolder = index?.averageScore
            if (averageScoreHolder != nil) {
                averageScoreDisplayText = "Average Score: \(averageScoreHolder!)%"
            } else {
                averageScoreDisplayText = "Average Score: N/A"
            }
            
            self.tempShowData.rating = averageScoreDisplayText
            
            /// Get show title
            if (index?.title?.english != nil) {
                self.tempShowData.title = (index?.title?.english)!
            } else {
                self.tempShowData.title = (index?.title?.romaji)!
            }
            
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
        apollo.fetch(query: GetPopularReleasingShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
            
            //MARK: Dismiss HUD
            hud.dismiss()
            
            self.storeDataInArray(data) // Caius would be proud
            
        }
        
    }
    
}
