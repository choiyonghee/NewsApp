//
//  NewsListTableViewHeaderView.swift
//  KeywordNews
//
//  Created by cyh on 2022/11/10.
//

import UIKit
import TTGTags

class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
	static let identifier = "NewsListTableViewHeaderView"
	private var currentIndex:UInt = 0
	
	private var tags: [String] = ["주식", "코로나", "아이폰", "개발", "개발자", "판교", "게임", "웹게임", "스타트업"]
	
	private lazy var tagCollectionView = TTGTextTagCollectionView()
	
	func setup() {
		contentView.backgroundColor = .systemBackground
		
		setupTagCollectionViewLayout()
		setupTagCollectionView()
	}
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
	func textTagCollectionView(
		_ textTagCollectionView: TTGTextTagCollectionView!,
		didTap tag: TTGTextTag!,
		at index: UInt
	) {
		guard tag.selected else { return }
		
		currentIndex = index
	}
	
	// Limit 1을 설정하면 다른게 선택이 안된다..
	func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, canTap tag: TTGTextTag!, at index: UInt) -> Bool {
		if index != currentIndex {
			tagCollectionView.updateTag(at: currentIndex, selected: false)
			tagCollectionView.reload()
		}

		return true
	}
}

private extension NewsListTableViewHeaderView {
	func setupTagCollectionViewLayout() {
		addSubview(tagCollectionView)
		
		tagCollectionView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	func setupTagCollectionView() {
		tagCollectionView.delegate = self
		tagCollectionView.numberOfLines = 1
		tagCollectionView.scrollDirection = .horizontal
		tagCollectionView.showsHorizontalScrollIndicator = false
		tagCollectionView.selectionLimit = 1
		
		let insetValue: CGFloat = 16.0
		tagCollectionView.contentInset = UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue)
		
		let cornerRadiusValue: CGFloat = 12.0
		let shadowOpacity: CGFloat = 0.0
		let extraSpace = CGSize(width: 20.0, height: 12.0)
		let color = UIColor.systemOrange

		let style = TTGTextTagStyle()
		style.backgroundColor = color
		style.cornerRadius = cornerRadiusValue
		style.borderWidth = 0.0
		style.shadowOpacity = shadowOpacity
		style.extraSpace = extraSpace
		
		let selectedStyle = TTGTextTagStyle()
		selectedStyle.backgroundColor = .white
		selectedStyle.cornerRadius = cornerRadiusValue
		selectedStyle.shadowOpacity = shadowOpacity
		selectedStyle.extraSpace = extraSpace
		selectedStyle.borderColor = color
		
		tags.forEach { tag in
			let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)

			let tagContents = TTGTextTagStringContent(
				text: tag,
				textFont: font,
				textColor: .white
			)
			 
			let selectedTagContents = TTGTextTagStringContent(
				text: tag,
				textFont: font,
				textColor: color
			)
			
			let tag = TTGTextTag(
				content: tagContents,
				style: style,
				selectedContent: selectedTagContents,
				selectedStyle: selectedStyle
			)
			
			tagCollectionView.addTag(tag)
			tagCollectionView.reload()
		}
	}
}
