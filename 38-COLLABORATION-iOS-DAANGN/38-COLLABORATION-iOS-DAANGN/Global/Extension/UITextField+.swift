//
//  UITextField+Extention.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit

extension UITextField {

    func addLeftPadding(_ width: CGFloat = 16) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ width: CGFloat = 16) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func addRightButton(_ button: UIButton, padding: CGFloat = 4) {
        let buttonSize: CGFloat = 24
        let containerWidth = buttonSize + padding
        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: buttonSize))
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        container.addSubview(button)

        self.rightView = container
        self.rightViewMode = .always
    }
}
