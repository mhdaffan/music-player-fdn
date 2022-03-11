//
//  ViewController+Alert.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import UIKit

extension ViewController {
    
    func showAlert(title: String, message: String) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: okStr, style: .default, handler: nil))
        self.present(viewController, animated: true)
    }
    
    func showError(error: Error) {
        if (error as NSError).code == 6 {
            showAlert(title: noConnectionStr, message: pleaseCheckYourConnectionStr)
        } else {
            showAlert(title: errorOccuredStr, message: error.localizedDescription)
        }
    }
    
}
