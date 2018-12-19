//
//  rouletteViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/14/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import JGProgressHUD

class rouletteViewController: UIViewController {
    @IBOutlet var showTitle: UILabel!
    @IBOutlet var studioName: UILabel!
    @IBOutlet weak var showArt: UIImageView!
    
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
    
    @IBAction func randomShowPopular(_ sender: Any) {
        grabPopular()
    }
    
    fileprivate func grabData(_ data: [GetShowQuery.Data.Page.Medium?]) {
        // Grab random value out of the shows grabbed
        let randomIndex = arc4random_uniform(UInt32(data.count))
        print("== Random Index: \(randomIndex)") // DEBUG
        
        // Get studio name via hacky method... tried using nodes[0] but swift didn't like that
        let getStudioNameHelper = data[data.index(Int(randomIndex), offsetBy:0)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        self.showTitle.text = data[data.index(Int(randomIndex), offsetBy:0)]?.title?.romaji
        
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
        hud.textLabel.text = "Taking out the trash..."
        hud.show(in: self.view)
        
        // Run Query
        apollo.fetch(query: GetShowQuery(genre: genre)) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope
            
            // Dismiss HUD
            hud.dismiss()
            
            self.grabData(data)
        }
    }
    
    fileprivate func grabPopularData(_ data: [GetPopularAiringShowsQuery.Data.Page.Medium?], _ randomIndex: UInt32) {
        // DEBUG
        
        let getStudioNameHelper = data[Int(randomIndex)]?.studios?.nodes
        
        if (getStudioNameHelper?.isEmpty == false) { // Check to see if a name was actually grabbed
            self.studioName.text = getStudioNameHelper?[0]?.name
        } else {
            self.studioName.text = "Unknown Studio"
        }
        
        // Get show title
        self.showTitle.text = data[Int(randomIndex)]?.title?.romaji
        
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
        hud.textLabel.text = "Taking out the trash..."
        hud.show(in: self.view)

        // Run Query
        apollo.fetch(query: GetPopularAiringShowsQuery(type: MediaType(rawValue: "ANIME"))) { result, _ in
            guard let data = result?.data?.page?.media else { return } // Note: guard exits scope while if let stays in scope

            // Dismiss HUD
            hud.dismiss()

            // Grab random value out of the shows grabbed
            let randomIndex = arc4random_uniform(UInt32(data.count))
            print("== Random Index: \(randomIndex)")
            self.grabPopularData(data, randomIndex)
        }
    }
}

