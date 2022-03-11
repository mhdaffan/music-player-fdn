//
//  UIView+Indicator.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import UIKit

extension UIView {
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                  appDelegate.window?.viewWithTag(99999) == nil else {
                return
            }
            
            let indicator = UIActivityIndicatorView(style: .medium).then {
                $0.startAnimating()
            }
            let layer = UIView().then {
                $0.backgroundColor = .black.withAlphaComponent(0.2)
                $0.tag = 99999
                $0.addSubview(indicator)
                indicator.snp.makeConstraints {
                    $0.centerX.centerY.equalToSuperview()
                }
            }
            
            appDelegate.window?.addSubview(layer)
            layer.snp.makeConstraints {
                $0.top.left.right.bottom.equalToSuperview()
            }
        }
    }
    
    func removeLoadingIndicator() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.window?.viewWithTag(99999)?.removeFromSuperview()
    }
    
}
