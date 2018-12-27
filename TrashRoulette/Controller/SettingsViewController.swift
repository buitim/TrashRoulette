//
//  SettingsViewController.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/26/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import UIKit
import QuickTableViewController
import SafariServices

class SettingsViewController: QuickTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableContents = [
            Section(title: "Information", rows: [
                NavigationRow(title: "Attribution", subtitle: .none, action: {[weak self] in self?.attributionSegue($0)}),
                NavigationRow(title: "GitHub Repo", subtitle: .none, action: {[weak self] in self?.openGitHubRepo($0)})
                ]),
            Section(title: "Contact", rows: [
                NavigationRow(title: "Website", subtitle: .none, action: {[weak self] in self?.openPortfolio($0)}),
                NavigationRow(title: "GitHub", subtitle: .none, action: {[weak self] in self?.openGitHubProfile($0)}),
                NavigationRow(title: "YouTube", subtitle: .none, action: {[weak self] in self?.openYoutubeProfile($0)})
                ])
        ]
    }

    func attributionSegue(_ sender: Row) {
        performSegue(withIdentifier: "AttributionViewSegue", sender: self)
    }
    
    func openGitHubProfile(_ sender: Row) {
        guard let url = URL(string: "https://github.com/buitim") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func openYoutubeProfile(_ sender: Row) {
        guard let url = URL(string: "https://www.youtube.com/SynapsePromotions") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func openGitHubRepo(_ sender: Row) {
        guard let url = URL(string: "https://github.com/buitim/TrashRoulette") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func openPortfolio(_ sender: Row) {
        guard let url = URL(string: "http://buitim.github.io") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}
