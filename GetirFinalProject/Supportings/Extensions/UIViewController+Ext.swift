//
//  UIViewController+Ext.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 21.04.2024.
//

import UIKit

extension UIViewController {
    func showLoader(_ present: Bool) {
        Task { @MainActor in
            if present {
                let loadingView = UIView()
                loadingView.frame = self.view.frame
                loadingView.backgroundColor = .getirGray
                loadingView.alpha = 0
                loadingView.tag = 1
                let indicator = UIActivityIndicatorView()
                indicator.style = .large
                indicator.color = .getirPurple
                indicator.center = self.view.center
                self.view.addSubview(loadingView)
                loadingView.addSubview(indicator)
                indicator.startAnimating()
                UIView.animate(withDuration: 0.3) {
                    loadingView.alpha = 0.9
                }
            } else {
                view.subviews.forEach { subview in
                    if subview.tag == 1 {
                        UIView.animate(withDuration: 0.3) {
                            subview.alpha = 0
                        } completion: { _ in
                            subview.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}
