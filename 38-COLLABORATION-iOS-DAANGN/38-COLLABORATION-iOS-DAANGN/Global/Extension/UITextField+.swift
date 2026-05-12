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
}
