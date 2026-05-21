//
//  FilterBottomSheetView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by Seoyoung Lee on 5/15/26.
//

import UIKit

import Then
import SnapKit

final class FilterBottomSheetView: UIView {

    private let handleAreaView = UIView()
    private let handleBarView = UIView()
    private let header = BottomSheetHeader()

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    private let bottomContainerView = UIView()
    var resetButton = UIButton()
    var applyButton = UIButton()

    private var gradientLayer: CAGradientLayer?

    private var allChips: [(button: ChipButton, title: String)] = []
    private var conditionChips: [(button: ChipButton, code: String)] = []
    private var tradeTypeChips: [(button: ChipButton, code: String)] = []
    private var priceInfoChips: [(button: ChipButton, code: String)] = []
    private var distanceChips: [(button: ChipButton, code: String)] = []
    private var minPriceTextField = UITextField()
    private var maxPriceTextField = UITextField()
    private var lastGroupContainerView = UIView()

    private let distanceCodeMap: [String: String] = [
        "500m": "DISTANCE_500",
        "1km": "DISTANCE_1KM",
        "2km": "DISTANCE_2KM_WITHIN",
        "2km이상": "DISTANCE_2KM_OVER"
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bottomContainerView.bounds
    }

    private func setStyle() {
        backgroundColor = .gray00
        handleBarView.do {
            $0.backgroundColor = .gray400
            $0.layer.cornerRadius = 2
        }
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
        contentStackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .fill
        }
        resetButton.do {
            $0.backgroundColor = .gray300
            $0.layer.cornerRadius = 10
            $0.setTitle("초기화", style: .h5Medium, color: .gray900)
        }
        applyButton.do {
            $0.backgroundColor = .gray900
            $0.layer.cornerRadius = 10
            $0.setTitle("적용하기", style: .h5Medium, color: .gray00)
        }
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.gray00.withAlphaComponent(0).cgColor,
            UIColor.gray00.cgColor
        ]
        gradient.locations = [0.0, 0.25]
        bottomContainerView.layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }

    private func setUI() {
        addSubviews(handleAreaView, header, scrollView, bottomContainerView, resetButton, applyButton)
        handleAreaView.addSubview(handleBarView)

        contentStackView.addArrangedSubview(makePriceSection())
        contentStackView.addArrangedSubview(makeDistanceSection())
        contentStackView.addArrangedSubview(lastGroupContainerView)

        let bottomSpacer = UIView()
        contentStackView.addArrangedSubview(bottomSpacer)
        bottomSpacer.snp.makeConstraints { $0.height.equalTo(100) }

        scrollView.addSubview(contentStackView)
    }

    private func setLayout() {
        handleAreaView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(28)
        }
        handleBarView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(4)
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.top.equalTo(handleAreaView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.width.equalTo(94)
            $0.height.equalTo(48)
        }
        applyButton.snp.makeConstraints {
            $0.leading.equalTo(resetButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(resetButton.snp.bottom)
            $0.height.equalTo(48)
        }
        bottomContainerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(resetButton.snp.top).offset(-24)
        }
    }
}

// MARK: - Section Builders

private extension FilterBottomSheetView {

    func makePriceSection() -> UIView {
        let container = UIView()
        let separator = makeSeparator()

        let titleLabel = makeSectionTitleLabel("가격")
        let titleWrapper = makeTitleWrapper(titleLabel)

        minPriceTextField = makePriceTextField(placeholder: "최소 금액")
        maxPriceTextField = makePriceTextField(placeholder: "최대 금액")
        let minField = minPriceTextField
        let maxField = maxPriceTextField

        let dashView = UIView().then {
            $0.backgroundColor = .gray1000
        }

        let inputRow = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.alignment = .center
        }
        inputRow.addArrangedSubview(minField)
        inputRow.addArrangedSubview(dashView)
        inputRow.addArrangedSubview(maxField)

        minField.snp.makeConstraints {
            $0.width.equalTo(157)
            $0.height.equalTo(49)
        }
        maxField.snp.makeConstraints {
            $0.width.equalTo(157)
            $0.height.equalTo(49)
        }
        dashView.snp.makeConstraints {
            $0.width.equalTo(5)
            $0.height.equalTo(1)
        }

        let chipsRow = makeChipsRow(chips: ["5만원 - 10만원", "10만원 - 15만원", "20만원 - 40만원"])

        let contentStack = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 12
            $0.alignment = .center
        }
        contentStack.addArrangedSubview(inputRow)
        contentStack.addArrangedSubview(chipsRow)

        chipsRow.snp.makeConstraints {
            $0.width.equalTo(contentStack.snp.width)
        }

        container.addSubviews(titleWrapper, contentStack, separator)

        titleWrapper.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        contentStack.snp.makeConstraints {
            $0.top.equalTo(titleWrapper.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(contentStack.snp.bottom).offset(24)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        return container
    }

    func makeDistanceSection() -> UIView {
        let container = UIView()
        let separator = makeSeparator()

        let titleLabel = makeSectionTitleLabel("거리")
        let titleWrapper = makeTitleWrapper(titleLabel)
        let chipsRow = makeDistanceChipsRow()

        container.addSubviews(titleWrapper, chipsRow, separator)

        titleWrapper.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        chipsRow.snp.makeConstraints {
            $0.top.equalTo(titleWrapper.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        separator.snp.makeConstraints {
            $0.top.equalTo(chipsRow.snp.bottom).offset(24)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        return container
    }

    func makeLastGroupSection(
        conditions: [(name: String, code: String)],
        tradeTypes: [(name: String, code: String)],
        priceInfos: [(name: String, code: String)]
    ) -> UIView {
        let container = UIView()

        let conditionSection = makeCategorySubSection(title: "상품 상태", chips: conditions, into: &conditionChips)
        let tradeSection = makeCategorySubSection(title: "거래방식", chips: tradeTypes, into: &tradeTypeChips)
        let priceInfoSection = makeCategorySubSection(title: "가격 정보", chips: priceInfos, into: &priceInfoChips)

        let groupStack = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .fill
        }
        groupStack.addArrangedSubview(conditionSection)
        groupStack.addArrangedSubview(tradeSection)
        groupStack.addArrangedSubview(priceInfoSection)

        container.addSubview(groupStack)
        groupStack.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }

        return container
    }

    func makeCategorySubSection(title: String, chips: [(name: String, code: String)], into store: inout [(button: ChipButton, code: String)]) -> UIView {
        let container = UIView()
        let titleLabel = makeSectionTitleLabel(title)
        let titleWrapper = makeTitleWrapper(titleLabel)
        let chipsRow = makeCategoryChipsRow(chips: chips, into: &store)

        container.addSubviews(titleWrapper, chipsRow)

        titleWrapper.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        chipsRow.snp.makeConstraints {
            $0.top.equalTo(titleWrapper.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        return container
    }
}

// MARK: - Factory Helpers

private extension FilterBottomSheetView {

    func makeSectionTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.setText(text, style: .h5Medium)
        return label
    }

    func makeTitleWrapper(_ label: UILabel) -> UIView {
        let wrapper = UIView()
        wrapper.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(16)
        }
        return wrapper
    }

    func makeSeparator() -> UIView {
        UIView().then { $0.backgroundColor = .gray200 }
    }

    func makePriceTextField(placeholder: String) -> UITextField {
        UITextField().then {
            $0.setPlaceholder(placeholder, style: .body1Regular, color: .gray700)
            $0.font = FontStyle.body1Regular.font
            $0.textColor = .gray1000
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray400.cgColor
            $0.layer.cornerRadius = 6
            $0.layer.masksToBounds = true
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
            $0.leftViewMode = .always
        }
    }

    func makeCategoryChipsRow(chips: [(name: String, code: String)], into store: inout [(button: ChipButton, code: String)]) -> UIView {
        let scrollView = UIScrollView().then {
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceHorizontal = false
        }
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }

        chips.forEach { pair in
            let button = makeChipButton(title: pair.name)
            store.append((button: button, code: pair.code))
            stackView.addArrangedSubview(button)
        }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        return scrollView
    }

    func makeDistanceChipsRow() -> UIView {
        let scrollView = UIScrollView().then {
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceHorizontal = false
        }
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }

        let distanceTitles = ["500m", "1km", "2km", "2km이상"]
        distanceTitles.forEach { title in
            let button = makeChipButton(title: title)
            let code = distanceCodeMap[title] ?? title
            distanceChips.append((button: button, code: code))
            button.onToggle = { [weak self, weak button] isSelected in
                guard let self, let button else { return }
                if isSelected {
                    self.distanceChips.forEach { pair in
                        if pair.button !== button {
                            pair.button.isSelected = false
                            pair.button.backgroundColor = .gray00
                            pair.button.layer.borderColor = UIColor.gray300.cgColor
                        }
                    }
                }
                button.backgroundColor = isSelected ? .gray800 : .gray00
                button.layer.borderColor = isSelected ? UIColor.gray800.cgColor : UIColor.gray300.cgColor
            }
            stackView.addArrangedSubview(button)
        }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        return scrollView
    }

    func makeChipsRow(chips: [String]) -> UIView {
        let scrollView = UIScrollView().then {
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceHorizontal = false
        }
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.alignment = .center
        }

        chips.forEach { stackView.addArrangedSubview(makeChipButton(title: $0)) }

        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        return scrollView
    }

    func makeChipButton(title: String) -> ChipButton {
        let button = ChipButton()
        button.setTitle(title, style: .body2Regular, color: .gray800, for: .normal)
        button.setTitle(title, style: .body2Regular, color: .gray00, for: .selected)
        button.backgroundColor = .gray00
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray300.cgColor
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        button.onToggle = { [weak button] isSelected in
            button?.backgroundColor = isSelected ? .gray800 : .gray00
            button?.layer.borderColor = isSelected
                ? UIColor.gray800.cgColor
                : UIColor.gray300.cgColor
        }
        allChips.append((button: button, title: title))
        return button
    }
}

// MARK: - Public Interface

extension FilterBottomSheetView {
    func addHandleBarGesture(_ gesture: UIGestureRecognizer) {
        handleAreaView.addGestureRecognizer(gesture)
    }

    func addCloseButtonTarget(_ target: Any?, action: Selector) {
        header.addCloseTarget(target, action: action)
    }

    func reset() {
        allChips.forEach {
            $0.button.isSelected = false
            $0.button.backgroundColor = .gray00
            $0.button.layer.borderColor = UIColor.gray300.cgColor
        }
        distanceChips.forEach {
            $0.button.isSelected = false
            $0.button.backgroundColor = .gray00
            $0.button.layer.borderColor = UIColor.gray300.cgColor
        }
        minPriceTextField.text = nil
        maxPriceTextField.text = nil
    }

    func selectedConditionCodes() -> [String] {
        conditionChips.filter { $0.button.isSelected }.map { $0.code }
    }

    func selectedTradeTypeCodes() -> [String] {
        tradeTypeChips.filter { $0.button.isSelected }.map { $0.code }
    }

    func selectedPriceInfoCodes() -> [String] {
        priceInfoChips.filter { $0.button.isSelected }.map { $0.code }
    }

    func selectedDistanceCode() -> String? {
        distanceChips.first { $0.button.isSelected }?.code
    }

    func priceRange() -> (min: Int?, max: Int?) {
        let min = minPriceTextField.text.flatMap { Int($0) }
        let max = maxPriceTextField.text.flatMap { Int($0) }
        return (min, max)
    }

    func restore(state: FilterState) {
        conditionChips.forEach { pair in
            let selected = state.conditionCodes.contains(pair.code)
            pair.button.isSelected = selected
            pair.button.backgroundColor = selected ? .gray800 : .gray00
            pair.button.layer.borderColor = selected ? UIColor.gray800.cgColor : UIColor.gray300.cgColor
        }
        tradeTypeChips.forEach { pair in
            let selected = state.tradeTypeCodes.contains(pair.code)
            pair.button.isSelected = selected
            pair.button.backgroundColor = selected ? .gray800 : .gray00
            pair.button.layer.borderColor = selected ? UIColor.gray800.cgColor : UIColor.gray300.cgColor
        }
        priceInfoChips.forEach { pair in
            let selected = state.priceInfoCodes.contains(pair.code)
            pair.button.isSelected = selected
            pair.button.backgroundColor = selected ? .gray800 : .gray00
            pair.button.layer.borderColor = selected ? UIColor.gray800.cgColor : UIColor.gray300.cgColor
        }
        distanceChips.forEach { pair in
            let selected = pair.code == state.distanceCode
            pair.button.isSelected = selected
            pair.button.backgroundColor = selected ? .gray800 : .gray00
            pair.button.layer.borderColor = selected ? UIColor.gray800.cgColor : UIColor.gray300.cgColor
        }
        if let min = state.minPrice { minPriceTextField.text = "\(min)" }
        if let max = state.maxPrice { maxPriceTextField.text = "\(max)" }
    }

    func configure(with categories: ProductCategoriesResponseDTO) {
        lastGroupContainerView.subviews.forEach { $0.removeFromSuperview() }
        conditionChips.removeAll()
        tradeTypeChips.removeAll()
        priceInfoChips.removeAll()

        let section = makeLastGroupSection(
            conditions: categories.conditions.map { (name: $0.name, code: $0.code) },
            tradeTypes: categories.tradeTypes.map { (name: $0.name, code: $0.code) },
            priceInfos: categories.priceInfos.map { (name: $0.name, code: $0.code) }
        )

        lastGroupContainerView.addSubview(section)
        section.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
