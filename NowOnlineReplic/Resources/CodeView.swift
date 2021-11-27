//
//  CodeView.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 15/11/21.
//

import Foundation

protocol CodeView {
    func configViews()
    func configConstraints()
    func additionalConfig()
}

extension CodeView {
    func setupConfigs(){
        configViews()
        configConstraints()
        additionalConfig()
    }
}
