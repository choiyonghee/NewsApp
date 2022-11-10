//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by cyh on 2022/11/10.
//

import UIKit

protocol NewsListProtocol: AnyObject {
	func setupNaviationBar()
	func setupLauyout()
	func endRefreshing()
}

class NewsListPresenter: NSObject {
	private weak var viewController:NewsListProtocol?

	init(viewController: NewsListProtocol) {
		self.viewController = viewController
	}
	
	func viewDidLoad() {
		viewController?.setupNaviationBar()
		viewController?.setupLauyout()
	}
	
	func didCalledRefresh() {
		viewController?.endRefreshing()
	}
}

extension NewsListPresenter: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension NewsListPresenter: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		15
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell
		
		cell?.setup()
		
		return cell ?? UITableViewCell()
	}
}
