//
//  NewsWebViewController.swift
//  KeywordNews
//
//  Created by cyh on 2022/11/14.
//

import WebKit
import SnapKit
import UIKit

class NewsWebViewController: UIViewController {
	private let webView = WKWebView()
	
	private let rightBarButtonItem = UIBarButtonItem(
		image: UIImage(systemName: "link"),
		style: .plain,
		target: self,
		action: #selector(didTapRightBarButtonItem)
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .yellow
		
		setupNavigationBar()
		setupWebView()
	}
}

private extension NewsWebViewController {
	func setupNavigationBar() {
		navigationItem.title = "기사 제목"
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}
	
	func setupWebView() {
		guard let linkURL = URL(string: "https://fastcampus.co.kr/") else {
			navigationController?.popViewController(animated: true)
			return
		}
		
		view = webView
		
		let urlRequest = URLRequest(url: linkURL)
		webView.load(urlRequest)
	}
	
	@objc func didTapRightBarButtonItem() {
		UIPasteboard.general.string = "뉴스 링크"
	}
}
