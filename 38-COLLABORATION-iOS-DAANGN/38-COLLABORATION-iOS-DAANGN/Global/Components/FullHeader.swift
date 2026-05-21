//
//  FullHeader.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/11/26.
//

import UIKit

import Then
import SnapKit

class FullHeader: UIView {
    
    let searchBar = SearchBarHeader()
    private let categoryTabBar = CategoryTabBar()
    private let filterChip = FilterChip()
    private let filterSortBar = FilterSortBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [searchBar, categoryTabBar, filterChip, filterSortBar].forEach { self.addSubview($0) }
    }
    
    var onFilterSelectionChanged: (([String]) -> Void)? {
        didSet { filterChip.onSelectionChanged = onFilterSelectionChanged }
    }

    func configure(with categories: ProductCategoriesResponseDTO) {
        let titles = categories.conditions.map { $0.name }
            + categories.tradeTypes.map { $0.name }
            + categories.priceInfos.map { $0.name }
        filterChip.configure(with: titles)
    }

    private func setLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        categoryTabBar.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }
        filterChip.snp.makeConstraints {
            $0.top.equalTo(categoryTabBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        filterSortBar.snp.makeConstraints {
            $0.top.equalTo(filterChip.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(37)
        }
    }
}
