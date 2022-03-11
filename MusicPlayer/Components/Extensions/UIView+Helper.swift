//
//  UIView+Helper.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
