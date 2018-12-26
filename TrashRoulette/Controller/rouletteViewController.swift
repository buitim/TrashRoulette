//
//  rouletteViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD

class rouletteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var showTitle: UILabel!
    @IBOutlet var studioName: UILabel!
    @IBOutlet weak var showArt: UIImageView!
    @IBOutlet weak var searchQueryPickerView: UIPickerView!
    @IBOutlet weak var isAiringUISwitch: UISwitch!
    
    let queryTypes = ["Popular", "Action", "Romance", "Comedy", "Adventure", "Drama", "Ecchi", "Fantasy", "Horror", "Mahou Shoujo", "Mecha", "Music", "Mystery", "Psychological", "Sci-Fi", "Slice of Life", "Sports", "Supernatural", "Thriller"]
    var rouletteQuery: String = "Popular"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showArt.layer.cornerRadius = 20
        searchQueryPickerView.delegate = self
        searchQueryPickerView.dataSource = self
        isAiringUISwitch.setOn(true, animated: false)
        grabPopular()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return queryTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return queryTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        rouletteQuery = queryTypes[row]
    }
    
    @IBAction func doLetJesusTakeTheWheel(_ sender: Any) {
        
        if (self.rouletteQuery != "Popular") {
            runQuery(genre: self.rouletteQuery)
        } else {
            grabPopular()
        }
    }
    
    
    // MARK: Grab data for current season show
    fileprivate func grabData(_ data: [GetAiringShowQuery.Data.Page.Medium?]) {
        // Grab random value out of the shows grabbed
        let randomIndex = arc4random_uniform(UInt32(data.count))
        
        // Get studio name via hacky method... tried using nodes[0] but swift didn't like that
        let getStudioNameHelper = data[data.index(Int(randomIndex), offsetBy:0)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            print("== English Title")
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            print("== Romaji Title")
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
        
        // Get studio name via hacky method... tried using nodes[0] but swift didn't like that
        let getStudioNameHelper = data[data.index(Int(randomIndex), offsetBy:0)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            print("== English Title")
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            print("== Romaji Title")
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
        
        let getStudioNameHelper = data[Int(randomIndex)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            print("== English Title")
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            print("== Romaji Title")
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        }
        
        // Get image
        let imageURL = URL(string: (data[Int(randomIndex)]?.coverImage?.extraLarge)!)
        self.showArt.setImage(url: imageURL!)
    }
    
    // MARK: Grab data for all popular shows
    fileprivate func grabPopularData(_ data: [GetPopularShowsQuery.Data.Page.Medium?], _ randomIndex: UInt32) {
        // DEBUG
        
        let getStudioNameHelper = data[Int(randomIndex)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        if (data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english != nil) {
            // If an english title exists, use it
            print("== English Title")
            self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.english
        } else { // Else use the romaji version
            print("== Romaji Title")
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
