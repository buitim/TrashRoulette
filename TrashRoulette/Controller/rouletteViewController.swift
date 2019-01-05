//
//  rouletteViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD
import PickerPopupDialog
import GoogleMobileAds

class rouletteViewController: UIViewController, GADInterstitialDelegate {
    
    // MARK: Interface Builder Outlets because I'm a lazy scrub
    @IBOutlet var showTitle: UILabel!
    @IBOutlet var showRating: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var showArt: UIImageView!
    @IBOutlet weak var isAiringUISwitch: UISwitch!
    
    // Initialize picker
    let pickerView = PickerPopupDialog()
    let pickerQueryTypes : [(Any, String)] = [(1, "Popular"), (2, "Action"), (3, "Romance"), (4, "Comedy"), (5, "Adventure"), (6, "Drama"), (7, "Ecchi"), (8, "Fantasy"), (9, "Horror"), (10, "Mahou Shoujo"), (11, "Mecha"), (12, "Music"), (13, "Mystery"), (14, "Psychological"), (15, "Sci-Fi"), (16, "Slice of Life"), (17, "Sports"), (18, "Supernatural"), (19, "Thriller")]
    var rouletteQuery: String = "Popular"
    
    // AdMob
    var interstitial: GADInterstitial!
    var clickCounter : Int = 0
    
    
    @objc func appMovedToBackground() {
        print("== Resetting value")
        clickCounter = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        // Load interstitial ad
        interstitial = createAndLoadInterstitial()
        
        // Clear Title and Rating
        self.showTitle.text = ""
        self.showRating.text = ""
        
        // Set Genre label to current roulette query ("Popular" by default)
        self.genreLabel.text = rouletteQuery
        genreLabel.numberOfLines = 1
        genreLabel.textAlignment = .right
        genreLabel.sizeToFit()
        
        // Set picker data source
        pickerView.setDataSource(pickerQueryTypes)
        
        // Initialize view
        showArt.layer.cornerRadius = 20
        isAiringUISwitch.setOn(true, animated: false)
        grabPopular()
        
        interstitial.delegate = self
        
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        
        let request = GADRequest()
        request.testDevices = [ "6897da95070b60bbb1c8caab4aead016" ] // Used for testing ads
        interstitial.load(request)
        
        return interstitial
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    // MARK: Haptic feedback when user toggles the switch
    @IBAction func presentUIToggleHapticFeedback(_ sender: Any) {
        let feedback = UISelectionFeedbackGenerator()
        feedback.selectionChanged()
    }
    
    @IBAction func invokeChangeGenrePicker(_ sender: Any) {
        pickerView.showDialog("Select Genre", doneButtonTitle: "Select", cancelButtonTitle: "Cancel") { (result) -> Void in
            
            self.rouletteQuery = result.1
            self.genreLabel.text = result.1
            
            // close window
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doLetJesusTakeTheWheel(_ sender: Any) {
        
        // MARK: Invoke haptic feedback on button press
        let feedback = UIImpactFeedbackGenerator(style: .medium)
        feedback.impactOccurred()
        
        if ((clickCounter % 10) == 0) {
            // Present Ad
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
        
        
        if (self.rouletteQuery != "Popular") {
            runQuery(genre: self.rouletteQuery)
        } else {
            grabPopular()
        }
        
        clickCounter += 1
        
    }
    
    
    // MARK: Grab data for current season show
    fileprivate func grabData(_ data: [GetAiringShowQuery.Data.Page.Medium?]) {
        // Grab random value out of the shows grabbed
        let randomIndex = arc4random_uniform(UInt32(data.count))
        
        // Get show rating
        let averageScoreHolder = data[data.index(Int(randomIndex), offsetBy:0)]?.averageScore
        var averageScoreDisplayText:String
        if (averageScoreHolder != nil){
            averageScoreDisplayText = "Average Score: \(averageScoreHolder!)%"
        } else {
            averageScoreDisplayText = "Average Score: N/A"
        }
        self.showRating.text = averageScoreDisplayText
        
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        }
        
        // Get image
        let imageURL = URL(string: (data[data.index(Int(randomIndex), offsetBy:0)]?.coverImage?.extraLarge)!)
        self.showArt.setImage(url: imageURL!)
    }
    
    // MARK: Grab data for all shows
    fileprivate func grabData(_ data: [GetAllShowQuery.Data.Page.Medium?]) {
        // Grab random value out of the shows grabbed
        let randomIndex = arc4random_uniform(UInt32(data.count))
        
        // Get show rating
        let averageScoreHolder = data[data.index(Int(randomIndex), offsetBy:0)]?.averageScore
        var averageScoreDisplayText:String
        if (averageScoreHolder != nil){
            averageScoreDisplayText = "Average Score: \(averageScoreHolder!)%"
        } else {
            averageScoreDisplayText = "Average Score: N/A"
        }
        self.showRating.text = averageScoreDisplayText
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        }
        
        // Get image
        let imageURL = URL(string: (data[data.index(Int(randomIndex), offsetBy:0)]?.coverImage?.extraLarge)!)
        self.showArt.setImage(url: imageURL!)
    }
    
    func runQuery(genre: String) {
        
        // Progress modal instance
        // Possible incorporate progress soon?
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 15
        hud.textLabel.text = "Shooting you with that trash..."
        hud.show(in: self.view)
        
        // Run Query
        if (isAiringUISwitch.isOn) {
            apollo.fetch(query: GetAiringShowQuery(genre: genre)) { result, _ in
                guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
                
                // Dismiss HUD
                hud.dismiss()
                
                self.grabData(data)
            }
        } else {
            apollo.fetch(query: GetAllShowQuery(genre: genre)) { result, _ in
                guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
                
                // Dismiss HUD
                hud.dismiss()
                
                self.grabData(data)
            }
        }
    }
    
    // MARK: Grab data for popular seasonal shows
    fileprivate func grabPopularData(_ data: [GetPopularAiringShowsQuery.Data.Page.Medium?], _ randomIndex: UInt32) {
        
        // Get show rating
        let averageScoreHolder = data[data.index(Int(randomIndex), offsetBy:0)]?.averageScore
        var averageScoreDisplayText:String
        if (averageScoreHolder != nil){
            averageScoreDisplayText = "Average Score: \(averageScoreHolder!)%"
        } else {
            averageScoreDisplayText = "Average Score: N/A"
        }
        self.showRating.text = averageScoreDisplayText
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        }
        
        // Get image
        let imageURL = URL(string: (data[Int(randomIndex)]?.coverImage?.extraLarge)!)
        self.showArt.setImage(url: imageURL!)
    }
    
    // MARK: Grab data for all popular shows
    fileprivate func grabPopularData(_ data: [GetPopularShowsQuery.Data.Page.Medium?], _ randomIndex: UInt32) {
        // DEBUG
        print("== Random Number: \(randomIndex)")
        print("Size of Array: \(data.count)")
        
        // Get show rating
        let averageScoreHolder = data[data.index(Int(randomIndex), offsetBy:0)]?.averageScore
        var averageScoreDisplayText:String
        if (averageScoreHolder != nil){
            averageScoreDisplayText = "Average Score: \(averageScoreHolder!)%"
        } else {
            averageScoreDisplayText = "Average Score: N/A"
        }
        self.showRating.text = averageScoreDisplayText
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        }
        
        // Get image
        let imageURL = URL(string: (data[Int(randomIndex)]?.coverImage?.extraLarge)!)
        self.showArt.setImage(url: imageURL!)
    }
    
    func grabPopular() {
        
        // Progress modal instance
        // Possible incorporate progress soon?
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.cornerRadius = 15
        hud.textLabel.text = "Shooting you with that trash..."
        hud.show(in: self.view)
        
        // Run Query
        if (isAiringUISwitch.isOn) {
            apollo.fetch(query: GetPopularAiringShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
                guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
                
                // Dismiss HUD
                hud.dismiss()
                
                // Grab random value out of the shows grabbed
                let randomIndex = arc4random_uniform(UInt32(data.count))
                self.grabPopularData(data, randomIndex)
            }
        } else {
            apollo.fetch(query: GetPopularShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
                guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
                
                // Dismiss HUD
                hud.dismiss()
                
                // Grab random value out of the shows grabbed
                let randomIndex = arc4random_uniform(UInt32(data.count))
                self.grabPopularData(data, randomIndex)
            }
        }
    }
}
