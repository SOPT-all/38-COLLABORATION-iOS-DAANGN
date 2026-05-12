//
//  UIView+Extention.swift
//  38-COLLABORATION-iOS-DAANGN
//
//  Created by 정교은 on 5/12/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
