//
//  AttributionTableViewContoller.swift
//  TrashRoulette
//
//  Created by Timothy Bui on 12/26/18.
//  Copyright © 2018 Timothy Bui. All rights reserved.
//

import QuickTableViewController
import SafariServices
import UIKit

class AttributionTableViewContoller: QuickTableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		tableContents = [
			Section(title: "Credits", rows: [
				NavigationRow(title: "Icons8", subtitle: .belowTitle("Icons"), action: { [weak self] in self?.openIcons8Website($0) }),
				NavigationRow(title: "AniList", subtitle: .belowTitle("API"), action: { [weak self] in self?.openAniList($0) }),
			]),
			Section(title: "Third-Party Libraries", rows: [
				NavigationRow(title: "Apollo GraphQL", subtitle: .none, action: { [weak self] in self?.openApollo($0) }),
				NavigationRow(title: "Imaginary", subtitle: .none, action: { [weak self] in self?.openImaginary($0) }),
				NavigationRow(title: "JGProgressHUD", subtitle: .none, action: { [weak self] in self?.openJGProgressHud($0) }),
				NavigationRow(title: "PickerPopupDialog", subtitle: .none, action: { [weak self] in self?.openPicker($0) }),
				NavigationRow(title: "LGButton", subtitle: .none, action: { [weak self] in self?.openLGButton($0) }),
				NavigationRow(title: "QuickTableViewController", subtitle: .none, action: { [weak self] in self?.openQuickTable($0) }),
			]),
		]
	}

	func openIcons8Website(_: Row) {
		guard let url = URL(string: "https://icons8.com/") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openAniList(_: Row) {
		guard let url = URL(string: "https://github.com/AniList/ApiV2-GraphQL-Docs") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openApollo(_: Row) {
		guard let url = URL(string: "https://www.apollographql.com/") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openImaginary(_: Row) {
		guard let url = URL(string: "https://github.com/hyperoslo/Imaginary") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openJGProgressHud(_: Row) {
		guard let url = URL(string: "https://github.com/JonasGessner/JGProgressHUD") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openPicker(_: Row) {
		guard let url = URL(string: "https://github.com/ribasal1/PickerPopupDialog") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openLGButton(_: Row) {
		guard let url = URL(string: "https://github.com/loregr/LGButton") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}

	func openQuickTable(_: Row) {
		guard let url = URL(string: "https://github.com/bcylin/QuickTableViewController") else { return }
		let svc = SFSafariViewController(url: url)
		present(svc, animated: true, completion: nil)
	}
}
