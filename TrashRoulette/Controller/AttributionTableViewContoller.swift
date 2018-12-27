//
//  AttributionTableViewContoller.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/26/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import QuickTableViewController
import SafariServices

class AttributionTableViewContoller: QuickTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableContents = [
            Section(title: "Credits", rows: [
                NavigationRow(title: "Icons8", subtitle: .belowTitle("Icons")),
                NavigationRow(title: "AniList", subtitle: .belowTitle("API")),
                NavigationRow(title: "Apollo GraphQL", subtitle: .none),
                NavigationRow(title: "Imaginary", subtitle: .none),
                NavigationRow(title: "JGProgressHUD", subtitle: .none),
                NavigationRow(title: "PickerPopupDialog", subtitle: .none),
                NavigationRow(title: "QuickTableViewController", subtitle: .none)
                ])
        ]
        
    }

}
