//
//  SimpleHeader.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/11/26.
//

import UIKit

import Then
import SnapKit

class SimpleHeader: UIView {
    
    let searchBar = SearchBarHeader()
    private let filterChip = FilterChip()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [searchBar, filterChip].forEach { self.addSubview($0) }
        backgroundColor = UIColor.white
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

    func setSelectedFilters(_ titles: Set<String>) {
        filterChip.setSelectedTitles(titles)
    }

    private func setLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        filterChip.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}
