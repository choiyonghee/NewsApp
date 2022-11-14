//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by cyh on 2022/11/10.
//

import UIKit
import SnapKit

class NewsListViewController: UIViewController {
	private lazy var prenseter: NewsListPresenter = NewsListPresenter(viewController: self)

	private lazy
	var refeshControl:UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
		
		return refreshControl
	}()

	private lazy var newListTableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = prenseter
		tableView.dataSource = prenseter
		tableView.register(
			NewsListTableViewCell.self,
			forCellReuseIdentifier: NewsListTableViewCell.identifier
		)
		tableView.register(
			NewsListTableViewHeaderView.self,
			forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier
		)
		
		tableView.refreshControl = refeshControl
		
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		prenseter.viewDidLoad()
	}
}

extension NewsListViewController: NewsListProtocol {
	func setupNaviationBar() {
		navigationItem.title = "NEWS"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func setupLauyout() {
		view.addSubview(newListTableView)
		
		newListTableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	func endRefreshing() {
		refeshControl.endRefreshing()
	}
	
	func moveToNewsWebViewController() {
		let newsWebViewController = NewsWebViewController()
		navigationController?.pushViewController(newsWebViewController, animated: true)
	}
}

private extension NewsListViewController {
	@objc func didCalledRefresh() {
		prenseter.didCalledRefresh()
	}
}
