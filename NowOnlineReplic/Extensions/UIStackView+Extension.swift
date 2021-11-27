//
//  UIStackView+Extension.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 26/11/21.
//
import UIKit

extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
    
}
