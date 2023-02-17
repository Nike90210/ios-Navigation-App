//
//  FunctionAddSubviews.swift
//  Navigator
//
//  Created by Jazzband on 17.02.2023.
//

import UIKit


extension UIView {

    func addMultipalSubviews(viewArray: [UIView]) {
        viewArray.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
