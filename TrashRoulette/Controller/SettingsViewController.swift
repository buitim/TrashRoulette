//
//  SettingsViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/26/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import QuickTableViewController

class SettingsViewController: QuickTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableContents = [
            Section(title: "Information", rows: [
                NavigationRow(title: "Attribution", subtitle: .none),
                NavigationRow(title: "GitHub Repo", subtitle: .none)
                ]),
            Section(title: "Contact", rows: [
                NavigationRow(title: "Website", subtitle: .none),
                NavigationRow(title: "GitHub", subtitle: .none),
                NavigationRow(title: "YouTube", subtitle: .none)
                ])
        ]
    }


}
