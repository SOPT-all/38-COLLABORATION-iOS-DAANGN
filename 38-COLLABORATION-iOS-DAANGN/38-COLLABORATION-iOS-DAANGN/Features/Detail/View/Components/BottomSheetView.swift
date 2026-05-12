//
//  BottomSheetView.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit
import Then
import SnapKit

final class BottomSheetView: UIView {
    var onSendButtonTapped: (() -> Void)?
    
    private var selectedOptionIndex = 0
    private var optionRowViews: [RadioOptionRowView] = []
    private let optionTexts = [
        "아직 구매 가능한가요?",
        "오늘 바로 거래 가능한가요?",
        "제품 상태를 자세하게 확인하고 싶어요.",
        "혹시 가격 조정 가능한가요?",
        "직접 입력"
    ]
    private let directInputOptionIndex = 4
    private let handleAreaView = UIView()
    private let handleBarView = UIView().then {
        $0.backgroundColor = .gray400
        $0.layer.cornerRadius = 3
    }
    private let titleLabel = UILabel().then {
        $0.setText("간편문의", style: .h4Medium)
    }
    private let subtitleLabel = UILabel().then {
        $0.setText("친절한 인삿말과 함께 문의가 전송돼요", style: .label3Regular, color: .gray800)
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray100
    }
    private let optionStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .fill
        $0.distribution = .fill
    }
    private let directInputTextField = UITextField().then {
        $0.setPlaceholder("상세 문의사항을 입력해주세요", style: .body1Regular, color: .gray700)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.addLeftPadding()
    }
    private let directInputContainerView = UIView().then {
        $0.isHidden = true
    }
    private let sendButton = UIButton().then {
        $0.setTitle("전송하기", style: .h5Medium, color: .gray00)
        $0.backgroundColor = .carrot600
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        backgroundColor = .gray00
        directInputTextField.addTarget(self, action: #selector(directInputTextFieldDidChanged), for: .editingChanged)
        sendButton.addTarget(self, action: #selector(sendButtonDidTapped), for: .touchUpInside)
    }
    
    private func setUI() {
        addSubviews(handleAreaView, titleLabel, subtitleLabel, dividerView, optionStackView, sendButton)
        handleAreaView.addSubview(handleBarView)
        
        optionRowViews = optionTexts.enumerated().map { index, text in
            let optionRowView = RadioOptionRowView(title: text, isSelected: index == selectedOptionIndex)
            optionRowView.tag = index
            optionRowView.addTarget(self, action: #selector(optionRowDidTapped), for: .touchUpInside)
            return optionRowView
        }
        
        optionRowViews.forEach {
            optionStackView.addArrangedSubview($0)
        }
        directInputContainerView.addSubview(directInputTextField)
        optionStackView.addArrangedSubview(directInputContainerView)
    }
    
    private func setLayout() {
        handleAreaView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        handleBarView.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(4)
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(36)
            $0.leading.equalTo(20)
        }
        subtitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(20)
        }
        dividerView.snp.makeConstraints{
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        optionStackView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            
        }
        directInputContainerView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        directInputTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview()
        }
        sendButton.snp.makeConstraints{
            $0.top.equalTo(optionStackView.snp.bottom).offset(24)
            $0.bottom.equalToSuperview().inset(36)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    @objc
    private func optionRowDidTapped(_ sender: RadioOptionRowView) {
        selectedOptionIndex = sender.tag
        updateOptionSelection()
    }
    
    private func updateOptionSelection() {
        optionRowViews.enumerated().forEach { index, optionRowView in
            optionRowView.isSelected = index == selectedOptionIndex
        }
        directInputContainerView.isHidden = selectedOptionIndex != directInputOptionIndex
        updateSendButtonState()
        layoutIfNeeded()
    }
    
    private func updateSendButtonState() {
        let isDirectInputSelected = selectedOptionIndex == directInputOptionIndex
        let hasDirectInputText = !(directInputTextField.text ?? "").isEmpty
        let isSendButtonEnabled = !isDirectInputSelected || hasDirectInputText
        
        sendButton.isEnabled = isSendButtonEnabled
        sendButton.backgroundColor = isSendButtonEnabled ? .carrot600 : .carrot400
    }
    
    @objc
    private func directInputTextFieldDidChanged() {
        updateSendButtonState()
    }
    
    @objc
    private func sendButtonDidTapped() {
        onSendButtonTapped?()
    }
}

extension BottomSheetView {
    
    func addHandleBarGesture(_ gesture: UIGestureRecognizer) {
        handleAreaView.addGestureRecognizer(gesture)
    }
}
